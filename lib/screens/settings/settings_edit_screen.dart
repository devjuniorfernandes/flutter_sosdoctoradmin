import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sosdoctorsystem/models/auth_model.dart';
import 'package:sosdoctorsystem/screens/auth/login_screen.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../../services/auth_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../loading_screen.dart';

class EditSettingScreen extends StatefulWidget {
  static const String id = 'editsetting-screen';
  const EditSettingScreen({Key? key}) : super(key: key);

  @override
  State<EditSettingScreen> createState() => _EditSettingScreenState();
}

class _EditSettingScreenState extends State<EditSettingScreen> {
  Auth? auth;
  bool loading = true;
  File? _pikerImage;
  Uint8List webImage = Uint8List(8);

/*
  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pikerImage = selected;
        });
      } else {
        // print("Nenhuma imagem selecionada!");
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pikerImage = File('a');
        });
      } else {
        // print("Nenhuma imagem selecionada!");
      }
    } else {
      // print("Algo deu errado!");
    }
  }
*/
  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        auth = response.data as Auth;
        loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoadingScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  //update profile
  void updateProfile() async {
    ApiResponse response = await updateImage(getStringImage(_pikerImage));
    setState(() {
      loading = false;
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
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
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, EditSettingScreen.id),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Center(
                    child: GestureDetector(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: _pikerImage == null
                            ? auth!.image != null
                                ? DecorationImage(
                                    image: NetworkImage('${auth!.image}'),
                                    fit: BoxFit.cover)
                                : null
                            : kIsWeb
                                ? DecorationImage(
                                    image: MemoryImage(webImage),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: FileImage(_pikerImage!),
                                    fit: BoxFit.cover),
                        color: Colors.amber),
                  ),
                  onTap: () {
                    /*
                    _pickImage();
                    */
                  },
                )),
                const SizedBox(
                  height: 20,
                ),
                Text('${auth!.name}'),
                const SizedBox(
                  height: 20,
                ),
                kTextButton('Update', () {
                  setState(() {
                    loading = true;
                  });
                  updateProfile();
                })
              ],
            ),
    );
  }
}
