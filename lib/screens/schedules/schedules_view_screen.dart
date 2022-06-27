import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/models/schedules_model.dart';
import '../../constant.dart';
import '../../models/schedules_model.dart';
import '../../widgets/sidebarmenu_widget.dart';
import 'schedules_list_screen.dart';

class ViewSchedulesScreen extends StatefulWidget {
  static const String id = 'viewschedules-screen';
  final SchedulesModel? schedules;
  final int? ref;
  const ViewSchedulesScreen({Key? key, this.schedules, this.ref})
      : super(key: key);

  @override
  State<ViewSchedulesScreen> createState() => _ViewSchedulesScreenState();
}

class _ViewSchedulesScreenState extends State<ViewSchedulesScreen> {
  @override
  void initState() {
    if (widget.schedules != null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Visualizar Agendamento'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: sideBar.sidebarMenus(context, ListSchedulesScreen.id),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Text(
                  'Agendamento AG00${widget.ref}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
              children: [
                Row(children: [
                  const Text("Informações",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                    child: widget.schedules!.status == 1
                        ? Chip(
                            backgroundColor: Colors.orange,
                            label: Row(
                              children: const [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Não Atendidodo",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        : Chip(
                            backgroundColor: Colors.blue,
                            label: Row(
                              children: const [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Atendido",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                  )
                ]),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "DADOS PESSOAIS",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Data do Agendamento: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            widget.schedules!.dateSchedules ?? '',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Nome do Paciente: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            widget.schedules!.namePatients ?? '',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Idade: ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  widget.schedules!.agePatients.toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Nº de Telefone: ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  widget.schedules!.phonePatients.toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: const [
                                Text(
                                  "Sexo: ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "Desconhecido",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Endereço: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                          Expanded(
                            child: Text(
                              widget.schedules!.addressPatients ?? '',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    /**  SECTION 2 */
                    const SizedBox(height: 50),
                    const Text(
                      "DADOS CLÍNICOS",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Assunto da Ocorrência: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            widget.schedules!.subject ?? '',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Informação da Ocorrência: ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.schedules!.description ?? '',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    /*
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Relato do Paciênte: ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        snapshot.data!['description_info'],
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    */
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
