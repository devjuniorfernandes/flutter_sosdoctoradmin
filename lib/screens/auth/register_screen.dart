// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosdoctorsystem/models/api_response.dart';
import 'package:sosdoctorsystem/screens/home_screen.dart';

import '../../constant.dart';
import '../../models/auth_model.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register-screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse response =
        await register(txtName.text, txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as Auth);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // Save and redirect to home
  void _saveAndRedirectToHome(Auth auth) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', auth.token ?? '');
    await pref.setInt('userId', auth.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            (states) => Colors.blue),
                        padding: MaterialStateProperty.resolveWith((states) =>
                            const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15))),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            const SizedBox(height: 10),
            kLoginRegisterHint("Já, tens uma conta?", "Entrar", () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            })
          ],
        ),
      ),
    );
  }
}
