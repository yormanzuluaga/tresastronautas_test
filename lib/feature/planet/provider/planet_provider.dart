import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:api_repository/api_repository.dart';
import 'package:api_helper/api_helper.dart';
import 'package:tresastronautas_test/app/database/planet_list_store.dart';

final planetRepositoryProvider = Provider<PlanetRepository>((ref) {
  final apiClient = ApiClient(); // Asume que tienes una instancia de ApiClient

  return PlanetRepositoryImpl(planetResource: PlanetResource(apiClient: apiClient));
});
final planetListStoreProvider = Provider<PlanetListStore>((ref) {
  return PlanetListStore.instance;
});

final planetProvider = StateNotifierProvider<PlanetNotifier, PlanetState>((ref) {
  return PlanetNotifier(
    ref.watch(planetRepositoryProvider),
    ref.watch(planetListStoreProvider),
  );
});

final planetNotifierProvider = StateNotifierProvider<PlanetNotifier, PlanetState>((ref) {
  final planetRepository = ref.watch(planetRepositoryProvider);
  final planetListStore = ref.watch(planetListStoreProvider);

  return PlanetNotifier(
    planetRepository,
    planetListStore,
  );
});

class PlanetState with EquatableMixin {
  final List<Datum>? listPlanet;
  final List<Datum>? aboveListPlanet;
  final List<Datum>? listPlanetSaved;
  final bool isLoading;
  final ApiException? error;

  PlanetState({
    this.listPlanet,
    this.aboveListPlanet,
    this.listPlanetSaved,
    this.isLoading = false,
    this.error,
  });

  PlanetState copyWith({
    List<Datum>? listPlanet,
    List<Datum>? aboveListPlanet,
    List<Datum>? listPlanetSaved,
    bool? isLoading,
    ApiException? error,
  }) {
    return PlanetState(
      listPlanet: listPlanet ?? this.listPlanet,
      aboveListPlanet: aboveListPlanet ?? this.aboveListPlanet,
      listPlanetSaved: listPlanetSaved ?? this.listPlanetSaved,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        aboveListPlanet,
        listPlanet,
        listPlanetSaved,
        isLoading,
        error,
      ];
}

class PlanetNotifier extends StateNotifier<PlanetState> {
  final PlanetRepository _planetRepository;
  final PlanetListStore _planetListStore;

  PlanetNotifier(
    this._planetRepository,
    this._planetListStore,
  ) : super(PlanetState());

  Future<void> getPlanet({Map<String, String>? headers}) async {
    state = state.copyWith(isLoading: true);

    final result = await _planetRepository.getPlanet(headers: headers);

    result.fold(
      (error) {
        state = state.copyWith(error: error, isLoading: false);
      },
      (planet) {
        state = state.copyWith(
          listPlanet: planet.data,
          aboveListPlanet: planet.data, // Guardamos la lista original
          isLoading: false,
        );
      },
    );
    if (_planetListStore.planetList.isNotEmpty) {
      final playList = (jsonDecode(_planetListStore.planetList) as List).map((e) => Datum.fromJson(e)).toList();

      state = state.copyWith(listPlanetSaved: playList, isLoading: false);
    } else {
      state = state.copyWith(listPlanetSaved: [], isLoading: false);
    }
  }

  Future<void> loadPlanetList() async {}

  Future<void> addPlanetListVideo(Datum planet) async {
    state = state.copyWith(isLoading: true);

    List<Datum> data = [];
    if (_planetListStore.planetList.isEmpty) {
      data.add(planet);
      await _planetListStore.savedPlanetLaist(planetList: jsonEncode(data));
      state = state.copyWith(listPlanetSaved: data, isLoading: false);
    } else {
      final planetList = (jsonDecode(_planetListStore.planetList) as List).map((e) => Datum.fromJson(e)).toList();

      final resultado = planetList.where((item) => item.name == planet.name);
      if (resultado.isEmpty) {
        planetList.add(planet);
        await _planetListStore.savedPlanetLaist(planetList: jsonEncode(planetList));
        state = state.copyWith(listPlanetSaved: planetList, isLoading: false);
      } else {
        getPlanet();
      }
    }
  } // Método para eliminar un video de la lista

  Future<void> removePlanetListVideo(Datum planet) async {
    state = state.copyWith(isLoading: true);

    if (_planetListStore.planetList.isNotEmpty) {
      final planetList = (jsonDecode(_planetListStore.planetList) as List).map((e) => Datum.fromJson(e)).toList();

      planetList.removeWhere((item) => item.name == planet.name);

      if (planetList.isEmpty) {
        await _planetListStore.removerPlanetLaist();
        state = state.copyWith(listPlanetSaved: planetList, isLoading: false);
      } else {
        await _planetListStore.savedPlanetLaist(planetList: jsonEncode(planetList));
        state = state.copyWith(listPlanetSaved: planetList, isLoading: false);
      }
    }
  }

  void searchPlanet(String query) {
    final data = state.listPlanet?.where((movie) {
      return movie.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    state = state.copyWith(listPlanet: data);
  }

  void resetSearch() {
    state = state.copyWith(
      listPlanet: state.aboveListPlanet,
      aboveListPlanet: state.aboveListPlanet,
    );
  }
}
