import 'package:flutter/material.dart';
import 'package:tresastronautas_test/feature/favorite_planet/view/favorite_planet_desktop.dart';
import 'package:tresastronautas_test/feature/favorite_planet/view/favorite_planet_mobile.dart';

class FavoritePlanetPage extends StatelessWidget {
  const FavoritePlanetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MediaQuery.of(context).size.width > 900 ? const FavoritePlanetDesktop() : const FavoritePlanetMobile();
      },
    );
  }
}
