import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tresastronautas_test/app/routes/routes_names.dart';
import 'package:tresastronautas_test/feature/planet/provider/planet_provider.dart';
import 'package:tresastronautas_ui/tresastronautas_ui.dart';

class HomeDesktop extends ConsumerWidget {
  const HomeDesktop({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planetNotifier = ref.read(planetNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.black,
        onTap: (value) {
          planetNotifier.getPlanet();
          value != 0 ? context.go(RoutesNames.planetSaved) : context.go(RoutesNames.planets);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos')
        ],
      ),
    );
  }
}
