import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosdoctorsystem/models/requisition_model.dart';
import 'package:sosdoctorsystem/screens/doc/requisitions/create_justifications_screen.dart';
import 'package:sosdoctorsystem/services/requisitions_service.dart';

import '../../../constant.dart';
import '../../../models/api_response.dart';
import '../../../models/requisition_model.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/boxUser_widget.dart';
import '../../../widgets/sidebarmenu_widget.dart';
import '../../auth/login_screen.dart';
import 'pdf/requisitions_pdf_page.dart';

class ListRequisitiomScreen extends StatefulWidget {
  static const String id = 'requisition-screen';
  const ListRequisitiomScreen({Key? key}) : super(key: key);

  @override
  State<ListRequisitiomScreen> createState() => _ListRequisitiomScreenState();
}

class _ListRequisitiomScreenState extends State<ListRequisitiomScreen> {
  List<dynamic> _requisitionList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getRequisitions();

    if (response.error == null) {
      setState(() {
        _requisitionList = response.data as List<dynamic>;
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

  void _getDocrequisition(RequisitionModel requisition) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('requisId', requisition.id ?? 0);
    await pref.setString('requisName', requisition.namePatients ?? '');
    await pref.setString('requisAge', requisition.agePatients ?? '');
    await pref.setString('requisPrediagnosis', requisition.preDiagnosis ?? '');
    await pref.setString('requisExames', requisition.exames ?? '');
    await pref.setString('requisDate', requisition.date ?? '');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequisitiomPdfScreen()),
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
        title: const Text('Requisições Medica'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListRequisitiomScreen.id),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Requisições Medica',
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
                                    const CreateRequisitiomScreen(),
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
                    itemCount: _requisitionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      RequisitionModel requisition = _requisitionList[index];
                      return ListTile(
                        onTap: () {
                          _getDocrequisition(requisition);
                        },
                        leading: SvgPicture.asset(
                          'assets/images/svg/requisition.svg',
                          width: 45,
                          height: 45,
                          color: Colors.grey[400],
                        ),
                        title: Text('${requisition.namePatients}'),
                        subtitle: Row(
                          children: [
                            Text('RQ000${requisition.id}'),
                            const SizedBox(width: 20),
                            Text('${requisition.date}'),
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
                                  requisition: requisition,
                                  ref: requisition.id,
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
