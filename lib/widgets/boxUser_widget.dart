import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class BoxUser extends StatefulWidget {
  const BoxUser({
    Key? key,
  }) : super(key: key);

  @override
  State<BoxUser> createState() => _BoxUserState();
}

class _BoxUserState extends State<BoxUser> {
  String nameUser = '';
  String imageUser = '';
  int id = 0;

  Future<void> getUserInfo() async {
    nameUser = await getUserName();
    imageUser = await getImage();
    setState(() {
      nameUser = nameUser;
      imageUser = imageUser;
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Row(
          children: [
            Text(
              nameUser,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(width: 10),
            imageUser == null
                ? const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://mrconfeccoes.com.br/wp-content/uploads/2018/03/default.jpg'),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(imageUser),
                  ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
