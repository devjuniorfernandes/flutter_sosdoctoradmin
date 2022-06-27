import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant.dart';

class InfoCard extends StatefulWidget {
  final String title;
  final String iconSvg;
  final String colletion;
  final Color topColor;
  final bool isActive;
  final Function onTap;

  const InfoCard({
    Key? key,
    required this.title,
    required this.iconSvg,
    required this.colletion,
    this.isActive = false,
    required this.onTap,
    required this.topColor,
  }) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  String numberCount = "50";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: kColorRed.withOpacity(.1),
                  blurRadius: 12)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    color: widget.topColor,
                    height: 5,
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      widget.iconSvg,
                      width: 60,
                      height: 50,
                      color: kColorPrimary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${widget.title}\n",
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              widget.isActive ? kColorRed : kColorPrimaryLight),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      numberCount,
                      style: TextStyle(
                          fontSize: 40,
                          color:
                              widget.isActive ? kColorRed : kColorPrimaryLight),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
