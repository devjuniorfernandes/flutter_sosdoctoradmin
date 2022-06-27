// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/models/api_response.dart';
import 'package:sosdoctorsystem/screens/users/users_list_screen.dart';

import '../../constant.dart';
import '../../services/user_service.dart';
import '../../widgets/sidebarmenu_widget.dart';

class UserRegisterScreen extends StatefulWidget {
  static const String id = 'admregister-screen';
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  bool loading = false;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "1", child: Text("Enfermeiro")),
      const DropdownMenuItem(value: "2", child: Text("Medico")),
      const DropdownMenuItem(value: "3", child: Text("Administrador")),
    ];
    return menuItems;
  }

  String? dropdownValue;

  void _registerUser() async {
    ApiResponse response =
        await registeradm(txtName.text, txtEmail.text, txtPassword.text, dropdownValue.toString());
    if (response.error == null) {
      loading = !loading;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ListUsersScreen()),
          (route) => false);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Criar Utilizadores'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: sideBar.sidebarMenus(context, ListUsersScreen.id),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            TextFormField(
              controller: txtName,
              keyboardType: TextInputType.text,
              validator: (val) =>
                  val!.isEmpty ? "Digite o nome completo" : null,
              decoration: kInputDecoration("Digite o nome completo"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
              validator: (val) =>
                  val!.isEmpty ? "Endereço de email invalido" : null,
              decoration: kInputDecoration("Digite seu E-maill"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: txtPassword,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.length < 6 ? "Senha invalida" : null,
              decoration: kInputDecoration("Digite seu Senha"),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
                hint: const Text('Não Selecionado'),
                value: dropdownValue,
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: dropdownItems),
            const SizedBox(height: 30),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          loading = !loading;
                          _registerUser();
                        });
                      } 
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => kColorPrimary),
                        padding: MaterialStateProperty.resolveWith((states) =>
                            const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15))),
                    child: const Text(
                      "CADASTRAR UTILIZADOR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
