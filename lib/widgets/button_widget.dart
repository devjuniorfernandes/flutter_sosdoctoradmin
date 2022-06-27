import 'package:flutter/material.dart';

import '../constant.dart';


class MyButtonDefault extends StatelessWidget {
  String text;
  Function onPressed;

  MyButtonDefault({Key? key, required this.text, required this.onPressed})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: kColorPrimary,
        minimumSize: const Size(
          150,
          50,
        ),
      ),
      onPressed: () => onPressed,
      child: Text(text),
    );
  }
}
