import 'package:flutter/material.dart';

import '../constant.dart';

class MyCircularIndicator extends StatelessWidget {
  const MyCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 35,
      width: 35,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          kColorPrimary,
        ),
      ),
    );
  }
}
