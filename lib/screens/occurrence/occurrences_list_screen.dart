import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../../models/occorrence_model.dart';
import '../../services/auth_service.dart';
import '../../services/occorrences_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';
import 'occurrences_create_screen.dart';
import 'occurrences_edit_screen.dart';
import 'occurrences_view_screen.dart';

class ListOccourenceScreen extends StatefulWidget {
  static const String id = 'occourrences-screen';
  const ListOccourenceScreen({Key? key}) : super(key: key);

  @override
  State<ListOccourenceScreen> createState() => _ListOccourenceScreenState();
}

class _ListOccourenceScreenState extends State<ListOccourenceScreen> {
  List<dynamic> _occorrenceList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getOccorrences();

    if (response.error == null) {
      setState(() {
        _occorrenceList = response.data as List<dynamic>;
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
    retrievePosts();
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
      sideBar: sideBar.sidebarMenus(context, ListOccourenceScreen.id),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Lista de Ocorrência',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
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
                                    const CreateOccourenceScreen(),
                              ),
                              (route) => false);
                        },
                        child: const Text("NOVA OCORRÊNCIA"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _occorrenceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      OccorrenceModel occorrence = _occorrenceList[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewOccourenceScreen(
                                    occorrence: occorrence,
                                    ref: occorrence.id)),
                          );
                        },
                        leading: occorrence.status == 1
                            ? SvgPicture.asset(
                                'assets/images/svg/livro-de-enderecos.svg',
                                width: 45,
                                height: 45,
                                color: kColorPrimaryLight,
                              )
                            : SvgPicture.asset(
                                'assets/images/svg/livro-de-enderecos.svg',
                                width: 45,
                                height: 45,
                                color: Colors.grey[400],
                              ),
                        title: Text('${occorrence.namePatients}'),
                        subtitle: Row(
                          children: [
                            Text('REF00${occorrence.id}'),
                            const SizedBox(width: 20),
                            Text('${occorrence.phonePatients}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditOccourenceScreen(
                                  occorrence: occorrence,
                                  ref: occorrence.id,
                                ),
                              ),
                            );
                          },
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
