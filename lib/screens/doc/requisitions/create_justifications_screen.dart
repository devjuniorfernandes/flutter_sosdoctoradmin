import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/models/api_response.dart';
import 'package:sosdoctorsystem/services/justifications_service.dart';
import 'package:sosdoctorsystem/services/requisitions_service.dart';

import '../../../constant.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/boxUser_widget.dart';
import '../../../widgets/circular_indicator_widget.dart';
import '../../../widgets/sidebarmenu_widget.dart';
import '../../auth/login_screen.dart';
import 'list_requisition_screen.dart';

class CreateRequisitiomScreen extends StatefulWidget {
  static const String id = 'createrequisitions-screen';
  const CreateRequisitiomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequisitiomScreen> createState() =>
      _CreateRequisitiomScreenState();
}

class _CreateRequisitiomScreenState extends State<CreateRequisitiomScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _diaginosisController = TextEditingController();
  final TextEditingController _examesController = TextEditingController();

  bool loading = false;
  String? dateController;

  void _createJustification() async {
    print(dateController);

    ApiResponse response = await createRequisition(
      _nameController.text,
      _ageController.text,
      _diaginosisController.text,
      _examesController.text,
      dateController.toString(),
    );

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ListRequisitiomScreen()),
          (route) => false);
    } else if (response == unauthorized) {
      logout().then((value) => [
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          ]);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        loading = !loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Criar Requisição Médica'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListRequisitiomScreen.id),
      body: loading
          ? const Center(child: MyCircularIndicator())
          : Form(
              key: formkey,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'Novo Requisição',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Dados Pessoais',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DateTimePicker(
                        locale: const Locale("pt", "BR"),
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Data',
                        timeLabelText: "Hora",
                        selectableDayPredicate: (date) {
                          // Disable weekend days to select from the calendar
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }

                          return true;
                        },
                        onChanged: (val) {
                          setState(() {
                            dateController = val;
                          });
                        },
                        validator: (val) {
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            dateController = val;
                          });
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Nome do Paciente",
                        label: Text("Nome do Paciente"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      controller: _ageController,
                      decoration: const InputDecoration(
                        hintText: "Idade do Paciente",
                        label: Text("Idade do Paciente"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _diaginosisController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Diagnostico Presuntivo",
                        label: Text("Diagnostico Presuntivo"),
                      ),
                    ),
                  ),
                                    Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _examesController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Exames",
                        label: Text("Exames"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              _createJustification();
                            }
                          },
                          child: const Text("GRAVAR REQUISIÇÃO"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
