// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../services/auth_service.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../home_screen.dart';
import 'login_screen.dart';

class LogoutScreen extends StatefulWidget {
  static const String id = 'logout-screen';
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final SideBarWidget _sideBar = SideBarWidget();

  _logoutUser() {
    logout().then((value) => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false)
        });
  }

  @override
  void initState() {
    _logoutUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      sideBar: _sideBar.sidebarMenus(context, HomeScreen.id),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
