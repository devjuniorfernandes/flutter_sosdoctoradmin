import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../../services/auth_service.dart';
import '../../services/schedules_service.dart';
import '../../widgets/boxUser_widget.dart';

import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';

class ListReportScreen extends StatefulWidget {
  static const String id = 'reports-screen';
  const ListReportScreen({Key? key}) : super(key: key);

  @override
  State<ListReportScreen> createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {
  List<dynamic> _reportssList = [];
  int userId = 0;
  int userlevel = 0;
  bool _loading = true;

  SideBarWidget sideBar = SideBarWidget();

  // get all posts
  Future<void> getReports() async {
    userId = await getUserId();
    userlevel = await getUserLevel();
    ApiResponse response = await getSchedules();

    if (response.error == null) {
      setState(() {
        _reportssList = response.data as List<dynamic>;
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
    getReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Lista de Relatórios"),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListReportScreen.id),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Lista de Relatórios',
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
                                /*
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateSchedulesScreen(),
                                    ),
                                    (route) => false);
                                    */
                              },
                              child: const Text("CRIAR RELATÓRIOS"),
                            )
                          : Container(),
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text("Ainda não tens relatórios"),
                  ),
                ),
              ],
            ),
    );
  }
}
