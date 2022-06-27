import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../constant.dart';
import '../../widgets/sidebarmenu_widget.dart';

class ClinicalHistoricScreen extends StatefulWidget {
  static const String id = 'clihistoric-screen';
  const ClinicalHistoricScreen({Key? key}) : super(key: key);

  @override
  State<ClinicalHistoricScreen> createState() => _ClinicalHistoricScreenState();
}

class _ClinicalHistoricScreenState extends State<ClinicalHistoricScreen> {
  final SideBarWidget _sideBar = SideBarWidget();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  bool loading = false;
  String? dateController;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pagina Inicial'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: _sideBar.sidebarMenus(context, ClinicalHistoricScreen.id),
      body: Form(
        key: formkey,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Adicionar Nova Ocorrência',
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
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(1930),
                  lastDate: DateTime.now(),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                controller: _idadeController,
                decoration: const InputDecoration(
                  hintText: "Idade",
                  label: Text("Idade"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _numberPhoneController,
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Nº de Telefone",
                  label: Text("Nº de Telefone"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Endereço",
                  label: Text("Digite seu Endereço"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Dados da Ocorrência',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _subjectController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Ocorrência",
                  label: Text("Ocorrência"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Relato do Paciente",
                  label: Text("Relato do Paciente"),
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

                        //
                      }
                    },
                    child: const Text("GRAVAR OCORRÊNCIA"),
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
