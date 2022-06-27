import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import '../../constant.dart';
import '../../models/occorrence_model.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';

class ViewOccourenceScreen extends StatefulWidget {
  static const String id = 'viewoccourrences-screen';
  final OccorrenceModel? occorrence;
  final int? ref;
  const ViewOccourenceScreen({Key? key, this.occorrence, this.ref})
      : super(key: key);

  @override
  State<ViewOccourenceScreen> createState() => _ViewOccourenceScreenState();
}

class _ViewOccourenceScreenState extends State<ViewOccourenceScreen> {
  @override
  void initState() {
    if (widget.occorrence != null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Visualizar Occorrência'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ViewOccourenceScreen.id),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Text(
                  'Occorrência REF${widget.ref}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // Text(widget.occorrence!.namePatients ?? ''),

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
                    child: widget.occorrence!.status == 1
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
                            "Nome do Paciente: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            widget.occorrence!.namePatients ?? '',
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
                                  widget.occorrence!.agePatients.toString(),
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
                                  widget.occorrence!.phonePatients.toString(),
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
                              widget.occorrence!.addressPatients ?? '',
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
                            widget.occorrence!.subject ?? '',
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
                        widget.occorrence!.description ?? '',
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
