// ignore_for_file: cast_nullable_to_non_nullable

part of 'router_config.dart';

Widget _homeHandler(BuildContext context, GoRouterState state, Widget child) {
  return HomePage(
    child: child,
  );
}

Page<Widget> _planetPageHandler(
  BuildContext context,
  GoRouterState state,
) {
  return NoTransitionPage(child: PlanetPage());
}

Page<Widget> _planetSavedPageHandler(
  BuildContext context,
  GoRouterState state,
) {
  return NoTransitionPage(child: FavoritePlanetPage());
}

Page<Widget> _detailPageHandler(
  BuildContext context,
  GoRouterState state,
) {
  final data = state.extra as List<String?>;
  return NoTransitionPage(
      child: Detail(
    title: data[0].toString(),
    url: data[1].toString(),
    descripto: data[2].toString(),
    orbitalDistanceKm: data[3].toString(),
    massKg: data[4].toString(),
  ));
}
