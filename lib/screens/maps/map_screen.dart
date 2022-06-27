import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../constant.dart';
import '../../widgets/sidebarmenu_widget.dart';


class MapScreen extends StatefulWidget {
  static const String id = 'map-screen';
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final SideBarWidget _sideBar = SideBarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Vista do Mapa'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: _sideBar.sidebarMenus(context, MapScreen.id),
      body: const Center(
        child: Text("Tela em Branco"),
      ),
    );
  }
}
