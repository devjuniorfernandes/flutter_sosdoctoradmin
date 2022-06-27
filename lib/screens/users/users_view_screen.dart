import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/screens/users/users_list_screen.dart';
import '../../constant.dart';
import '../../models/user_model.dart';
import '../../widgets/sidebarmenu_widget.dart';

class ViewUserScreen extends StatefulWidget {
  static const String id = 'viewsuser-screen';
  final User? user;
  const ViewUserScreen({Key? key, this.user}) : super(key: key);

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  
  @override
  void initState() {
    if (widget.user != null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Visualizar Utilizador'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: sideBar.sidebarMenus(context, ListUsersScreen.id),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
              children: [
                Text(
                  widget.user!.name.toString(),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.user!.email.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "DADOS PESSOAIS",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
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
