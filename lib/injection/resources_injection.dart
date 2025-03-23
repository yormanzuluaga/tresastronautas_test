part of 'injection_container.dart';

void _initResourcesInjections() {
  sl.registerFactory<PlanetResource>(() => PlanetResource(
        apiClient: sl(),
      ));
}
