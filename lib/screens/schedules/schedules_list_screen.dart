import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sosdoctorsystem/screens/schedules/schedules_create_screen.dart';
import 'package:sosdoctorsystem/screens/schedules/schedules_edit_screen.dart';
import 'package:sosdoctorsystem/screens/schedules/schedules_view_screen.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../../models/schedules_model.dart';
import '../../services/auth_service.dart';
import '../../services/schedules_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';

class ListSchedulesScreen extends StatefulWidget {
  static const String id = 'schedules-screen';
  const ListSchedulesScreen({Key? key}) : super(key: key);

  @override
  State<ListSchedulesScreen> createState() => _ListSchedulesScreenState();
}

class _ListSchedulesScreenState extends State<ListSchedulesScreen> {
  List<dynamic> _schedulesList = [];
  int userId = 0;
  int userlevel = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    userlevel = await getUserLevel();
    ApiResponse response = await getSchedules();

    if (response.error == null) {
      setState(() {
        _schedulesList = response.data as List<dynamic>;
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
        title: const Text("Lista de Agendamento"),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListSchedulesScreen.id),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Agendamentos',
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
                                          const CreateSchedulesScreen(),
                                    ),
                                    (route) => false);
                              },
                              child: const Text("NOVO AGÊNDAMENTO"),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _schedulesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      SchedulesModel schedules = _schedulesList[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewSchedulesScreen(
                                    schedules: schedules, ref: schedules.id)),
                          );
                        },
                        leading: schedules.status == 1
                            ? SvgPicture.asset(
                                'assets/images/svg/calendario.svg',
                                width: 40,
                                height: 40,
                                color: kColorPrimaryLight,
                              )
                            : SvgPicture.asset(
                                'assets/images/svg/calendario.svg',
                                width: 40,
                                height: 40,
                                color: Colors.grey[400],
                              ),
                        title: Text('${schedules.namePatients}'),
                        subtitle: Row(
                          children: [
                            Text('AG00${schedules.id}'),
                            const SizedBox(width: 20),
                            Text('${schedules.phonePatients}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSchedulesScreen(
                                  schedules: schedules,
                                  ref: schedules.id,
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
