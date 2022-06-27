import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../constant.dart';
import '../widgets/sidebarmenu_widget.dart';

class SimpleScreen extends StatefulWidget {
  static const String id = 'simple-screen';
  const SimpleScreen({Key? key}) : super(key: key);

  @override
  State<SimpleScreen> createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  final SideBarWidget _sideBar = SideBarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pagina Inicial'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: _sideBar.sidebarMenus(context, SimpleScreen.id),
      body: const Center(
        child: Text("Tela em Branco"),
      ),
    );
  }
}
