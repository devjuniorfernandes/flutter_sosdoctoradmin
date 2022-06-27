import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import '../constant.dart';
import '../services/auth_service.dart';
import '../widgets/boxUser_widget.dart';
import '../widgets/dashboar_large_widget.dart';
import '../widgets/dashboar_m_widget.dart';
import '../widgets/responsive.dart';
import '../widgets/sidebarmenu_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int userId = 0;
  int userlevel = 0;

  SideBarWidget sideBar = SideBarWidget();

  Future<void> getInstance() async {
    userId = await getUserId();
    userlevel = await getUserLevel();
  }

  @override
  void initState() {
    getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pagina Inicial'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, HomeScreen.id),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Comparation Acess Level
            if (userlevel != 1)
              // Comparation Size Divice
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: OverviewCardsLargeScreen(),
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: OverviewCardsMediumScreen(),
                )
            // End Comparation Size Divice
            else
              Container(),
            // End Comparation Acess Level
            const Center(
              child: Text("Ups! Não existe relatótio de momento."),
            ),
          ],
        ),
      ),
    );
  }
}
