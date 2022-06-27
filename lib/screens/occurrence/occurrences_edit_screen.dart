import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/models/api_response.dart';

import '../../constant.dart';
import '../../models/occorrence_model.dart';
import '../../services/auth_service.dart';
import '../../services/occorrences_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/circular_indicator_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';
import 'occurrences_list_screen.dart';

class EditOccourenceScreen extends StatefulWidget {
  static const String id = 'editoccorrence-screen';
  final OccorrenceModel? occorrence;
  final int? ref;
  const EditOccourenceScreen({Key? key, this.occorrence, this.ref})
      : super(key: key);

  @override
  State<EditOccourenceScreen> createState() => _EditOccourenceScreenState();
}

class _EditOccourenceScreenState extends State<EditOccourenceScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  bool loading = false;

  void _handleDeleteOccurrence(int id) async {
    ApiResponse response = await deleteOccorrences(id);
    if (response.error == null) {
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    if (widget.occorrence != null) {
      _nameController.text = widget.occorrence!.namePatients ?? '';
      _addressController.text = widget.occorrence!.addressPatients ?? '';
      _descriptionController.text = widget.occorrence!.description ?? '';
      _idadeController.text = widget.occorrence!.agePatients.toString();
      _numberPhoneController.text = widget.occorrence!.phonePatients.toString();
      _subjectController.text = widget.occorrence!.subject ?? '';
    }
    super.initState();
  }

  void _editOccorrence(int idOccorrence) async {
    ApiResponse response = await editOccorrence(
      idOccorrence,
      _nameController.text,
      _addressController.text,
      _descriptionController.text,
      _idadeController.text,
      _numberPhoneController.text,
      _subjectController.text,
    );

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ListOccourenceScreen()),
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
        title: const Text('Editando de Occorrência'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListOccourenceScreen.id),
      body: loading
          ? const Center(child: MyCircularIndicator())
          : Form(
              key: formkey,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      children: [
                        Text(
                          'Occorrência REF${widget.ref.toString()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: kColorRed,
                            minimumSize: const Size(
                              150,
                              50,
                            ),
                          ),
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                    'Ocorrência REF00${widget.occorrence!.id.toString()}'),
                                content: const Text(
                                    'Se apagar essa ocorrência já não poderá reaver ela, nem as seus relatório.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _handleDeleteOccurrence(
                                          widget.occorrence!.id ?? 0);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ListOccourenceScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'CONFIRMAR',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("APAGAR OCORRÊNCIA"),
                        ),
                      ],
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
                      controller: _idadeController,
                      decoration: const InputDecoration(
                        hintText: "Idade",
                        label: Text("Idade"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                            }
                            _editOccorrence(widget.occorrence!.id ?? 0);
                          },
                          child: const Text("EDITAR OCORRÊNCIA"),
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
