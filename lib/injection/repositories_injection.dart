part of 'injection_container.dart';

void _initRepositoriesInjections() {
  sl.registerFactory<PlanetRepository>(() => PlanetRepositoryImpl(planetResource: sl()));
}
