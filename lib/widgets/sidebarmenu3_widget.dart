import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../constant.dart';
import '../screens/auth/logout_screen.dart';
import '../screens/home_screen.dart';
import '../screens/occurrence/occurrences_list_screen.dart';
import '../screens/schedules/schedules_list_screen.dart';
import '../screens/settings/settings_view_screen.dart';
import '../screens/users/users_list_screen.dart';

class SideBarWidget3 {
  var timeNow = DateTime.now();

  final List<AdminMenuItem> _sideBarItems = const [
    AdminMenuItem(
      title: 'Painel Inicial',
      route: HomeScreen.id,
      icon: Icons.dashboard_outlined,
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
        icon: Icons.supervisor_account_outlined),
    AdminMenuItem(
      title: 'Definições',
      route: ViewSettingScreen.id,
      icon: Icons.settings_outlined,
    ),
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
        height: 200,
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
