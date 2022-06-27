import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/models/auth_model.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../../services/auth_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../loading_screen.dart';

class ViewSettingScreen extends StatefulWidget {
  static const String id = 'viewsetting-screen';
  const ViewSettingScreen({Key? key}) : super(key: key);

  @override
  State<ViewSettingScreen> createState() => _ViewSettingScreenState();
}

class _ViewSettingScreenState extends State<ViewSettingScreen> {
  Auth? auth;
  bool loading = true;

  String nameUser = '';
  String imageUser = '';
  int userId = 0;
  int userlevel = 0;

  Future<void> getUserInfo() async {
    nameUser = await getUserName();
    imageUser = await getImage();
    userlevel = await getUserLevel();
    setState(() {
      nameUser = nameUser;
      imageUser = imageUser;
      userlevel = userlevel;
    });
  }

  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        auth = response.data as Auth;
        loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoadingScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Visualizar Utilizador'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ViewSettingScreen.id),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
              children: [
                Row(
                  children: [
                    imageUser == null
                        ? const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/default.jpg'),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            backgroundImage: NetworkImage(imageUser, scale: 5),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          auth!.name.toString(),
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          auth!.email.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "MAIS INFORMAÇÕES",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
