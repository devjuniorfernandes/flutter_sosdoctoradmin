import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoxDashboard extends StatelessWidget {
  String text;
  int number;
  String icon;
  BoxDashboard({
    Key? key,
    required this.text,
    required this.number,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFC7ECFF),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: const Color(0xff1373EB),
                    borderRadius: BorderRadius.circular(10)),
                child: SvgPicture.asset(
                  icon,
                  color: Colors.white,
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(width: 15),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "58",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
