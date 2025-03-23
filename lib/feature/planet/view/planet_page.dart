import 'package:flutter/material.dart';
import 'package:tresastronautas_test/feature/planet/view/planet_desktop.dart';
import 'package:tresastronautas_test/feature/planet/view/planet_mobile.dart';

class PlanetPage extends StatelessWidget {
  const PlanetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MediaQuery.of(context).size.width > 900 ? PlanetDesktop() : PlanetMobile();
      },
    );
  }
}
