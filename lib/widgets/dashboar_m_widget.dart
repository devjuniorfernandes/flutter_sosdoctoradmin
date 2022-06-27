import 'package:flutter/material.dart';
import 'info_card_widget.dart';

class OverviewCardsLargeScreen extends StatefulWidget {
  const OverviewCardsLargeScreen({Key? key}) : super(key: key);

  @override
  State<OverviewCardsLargeScreen> createState() => _OverviewCardsLargeScreenState();
}

class _OverviewCardsLargeScreenState extends State<OverviewCardsLargeScreen> {

 
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          iconSvg: 'assets/images/svg/livro-de-enderecos.svg',
          title: 'Ocorrências',
          colletion: "patients",
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          iconSvg: 'assets/images/svg/calendario.svg',
          title: "Agendamentos",
          colletion: "scheduling",
          topColor: Colors.lightGreen,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          iconSvg: 'assets/images/svg/document.svg',
          title: "Relatórios",
          colletion: "reports",
          topColor: Colors.redAccent,
          onTap: () {},
        ),
      ],
    );
  }
}
