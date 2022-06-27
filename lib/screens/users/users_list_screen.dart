import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/models/user_model.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';
import 'users_register_screen.dart';
import 'users_view_screen.dart';

class ListUsersScreen extends StatefulWidget {
  static const String id = 'listusers-screen';
  const ListUsersScreen({Key? key}) : super(key: key);

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  List<dynamic> _userList = [];
  int userId = 0;
  bool _loading = true;
  int userlevel = 0;

  // get all posts
  Future<void> retrieveAllUsers() async {
    userId = await getUserId();
    userlevel = await getUserLevel();
    ApiResponse response = await getUsers();

    if (response.error == null) {
      setState(() {
        _userList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    retrieveAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Lista de Occorrência'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListUsersScreen.id),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Lista de Utilizadores',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      userlevel > 1
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: kColorPrimary,
                                minimumSize: const Size(
                                  150,
                                  50,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserRegisterScreen(),
                                    ),
                                    (route) => false);
                              },
                              child: const Text("NOVO UTILIZADOR"),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = _userList[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewUserScreen(user: user),
                            ),
                          );
                        },
                        leading: user.image != null || user.image == ''
                            ? CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage('${user.image}'),
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    'https://mrconfeccoes.com.br/wp-content/uploads/2018/03/default.jpg'),
                              ),
                        title: Text('${user.name}'),
                        subtitle: Row(
                          children: [
                            Text('${user.email}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
