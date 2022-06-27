// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosdoctorsystem/models/api_response.dart';

import '../../constant.dart';
import '../../models/auth_model.dart';
import '../../services/auth_service.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirecToHome(response.data as Auth);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirecToHome(Auth auth) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', auth.token ?? '');
    await pref.setInt('userId', auth.id ?? 0);
    await pref.setInt('level', auth.level ?? 0);
    await pref.setString('name', auth.name ?? '');
    await pref.setString('image', auth.image ?? '');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: ListView(
                  padding: const EdgeInsets.all(32),
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    TextFormField(
                      controller: txtEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val!.isEmpty ? "Endereço de email invalido" : null,
                      decoration: kInputDecoration("Digite o seu e-mail "),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      controller: txtPassword,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val!.length < 6 ? "Senha invalida" : null,
                      decoration: kInputDecoration("Digite a sua senha"),
                    ),
                    const SizedBox(height: 30),
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: kColorPrimary,
                                minimumSize: const Size(
                                  double.infinity,
                                  50,
                                ),
                              ),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                    _loginUser();
                                  });
                                }
                              },
                              child: const Text("ENTRAR"),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
