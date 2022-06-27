import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/screens/clinical/create_historic_screen.dart';
import 'package:sosdoctorsystem/screens/doc/justifications/list_justifications_screen.dart';
import 'package:sosdoctorsystem/screens/doc/requisitions/list_requisition_screen.dart';

import '../constant.dart';
import '../screens/auth/logout_screen.dart';
import '../screens/home_screen.dart';
import '../screens/occurrence/occurrences_list_screen.dart';
import '../screens/schedules/schedules_list_screen.dart';
import '../screens/users/users_list_screen.dart';

class SideBarWidget {
  var timeNow = DateTime.now();

  final List<AdminMenuItem> _sideBarItems = const [
    AdminMenuItem(
      title: 'Painel Inicial',
      route: HomeScreen.id,
      icon: Icons.dashboard_outlined,
    ),
    AdminMenuItem(
      title: 'H. Clinico',
      route: CreateHistoricScreen.id,
      icon: Icons.history,
    ),
    AdminMenuItem(
      title: 'Ocorrências',
      route: ListOccourenceScreen.id,
      icon: Icons.feed_outlined,
    ),
    AdminMenuItem(
      title: 'Agendamentos',
      route: ListSchedulesScreen.id,
      icon: Icons.event_note_outlined,
    ),
    AdminMenuItem(
      title: 'Utilizadores',
      route: ListUsersScreen.id,
      icon: Icons.supervisor_account_outlined,
    ),
    AdminMenuItem(
      title: 'Requisições',
      route: ListRequisitiomScreen.id,
      icon: Icons.list_alt_outlined,
    ),
    AdminMenuItem(
      title: 'Justificativos',
      route: ListJustificationScreen.id,
      icon: Icons.list_alt_outlined,
    ),
    /*
    AdminMenuItem(
      title: 'Definições',
      route: ViewSettingScreen.id,
      icon: Icons.settings_outlined,
    ),
    */
    AdminMenuItem(
      title: 'Terminar Sessão',
      route: LogoutScreen.id,
      icon: Icons.logout_outlined,
    ),
  ];

  sidebarMenus(context, selectedRout) {
    return SideBar(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      iconColor: kColorPrimary,
      activeIconColor: Colors.white,
      activeBackgroundColor: kColorPrimary,
      textStyle: const TextStyle(
        color: kColorPrimary,
        fontSize: 15,
      ),
      activeTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      items: _sideBarItems,
      selectedRoute: selectedRout,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 150,
        width: double.infinity,
        color: const Color.fromARGB(255, 233, 233, 233),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/images/logo.png'),
        )),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: const Color.fromARGB(255, 233, 233, 233),
        child: Center(
          child: Text(
            timeNow.toString(),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
