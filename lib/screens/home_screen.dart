import 'package:flutter/material.dart';
import 'package:grupolenotre/tabs/relatorio_tab.dart';
import 'package:grupolenotre/tabs/filial_tab.dart';
import 'package:grupolenotre/tabs/home_tab.dart';
import 'package:grupolenotre/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 66, 163, 177),
          ),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Filiais"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 66, 163, 177),
          ),
          body: FilialTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Relatório Diário"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 66, 163, 177),
          ),
          body: RelatorioTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
