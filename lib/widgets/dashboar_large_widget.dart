
import 'package:flutter/material.dart';

import 'info_card_widget.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  const OverviewCardsMediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              iconSvg: 'assets/images/svg/livro-de-enderecos.svg',
              title: "Ocorrências",
              colletion: "patients",
              onTap: () {},
              topColor: Colors.orange,
            ),
          ],
        ),
        SizedBox(
          height: _width / 64,
        ),
        Row(
          children: [
            InfoCard(
              iconSvg: 'assets/images/svg/calendario.svg',
              title: "Agendamento",
              colletion: "scheduling",
              topColor: Colors.redAccent,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              iconSvg: 'assets/images/svg/document.svg',
              title: "Relatórios",
              colletion: "reports",
              onTap: () {},
              topColor: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}