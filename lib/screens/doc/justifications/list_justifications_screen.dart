import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosdoctorsystem/models/justification_model.dart';
import 'package:sosdoctorsystem/services/justifications_service.dart';

import '../../../constant.dart';
import '../../../models/api_response.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/boxUser_widget.dart';
import '../../../widgets/sidebarmenu_widget.dart';
import '../../auth/login_screen.dart';
import 'create_justifications_screen.dart';
import 'pdf/pdf_page.dart';

class ListJustificationScreen extends StatefulWidget {
  static const String id = 'justifications-screen';
  const ListJustificationScreen({Key? key}) : super(key: key);

  @override
  State<ListJustificationScreen> createState() =>
      _ListJustificationScreenState();
}

class _ListJustificationScreenState extends State<ListJustificationScreen> {
  List<dynamic> _justificationList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getJustifications();

    if (response.error == null) {
      setState(() {
        _justificationList = response.data as List<dynamic>;
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

  void _getDocJustification(JustificationModel justification) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('justfID', justification.id ?? 0);
    await pref.setString('justfName', justification.namePatients ?? '');
    await pref.setString('justfSubject', justification.description ?? '');
    await pref.setString('justfDate', justification.date ?? '');
    await pref.setString('justfBI', justification.biPatients ?? '');
    await pref.setString('justfDays', justification.days ?? '');
    await pref.setString('justfAfter', justification.after ?? '');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PdfScreen()),
    );
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
        title: const Text('Justificativos'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListJustificationScreen.id),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Justificativos',
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
                                    const CreateJustificationScreen(),
                              ),
                              (route) => false);
                        },
                        child: const Text("CRIAR NOVO"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _justificationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      JustificationModel justification =
                          _justificationList[index];
                      return ListTile(
                        onTap: () {
                          _getDocJustification(justification);
                        },
                        leading: SvgPicture.asset(
                          'assets/images/svg/atestado.svg',
                          width: 45,
                          height: 45,
                          color: Colors.grey[400],
                        ),
                        title: Text('${justification.namePatients}'),
                        subtitle: Row(
                          children: [
                            Text('JM000${justification.id}'),
                            const SizedBox(width: 20),
                            Text('${justification.date}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditOccourenceScreen(
                                  justification: justification,
                                  ref: justification.id,
                                ),
                              ),
                            );
                            */
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
