import 'package:shared_preferences/shared_preferences.dart';
import 'package:tresastronautas_test/app/database/db.dart';
import 'package:tresastronautas_test/app/helper/preferences_helper.dart';

class PlanetListStore {
  PlanetListStore._internal();

  static final PlanetListStore _instance = PlanetListStore._internal();

  static PlanetListStore get instance => _instance;

  String _planetList = '';

  String get planetList => _planetList;

  final SharedPreferences _sharedPreferences = DB.instance.prefs;

  Future<void> init() async {
    _planetList = _sharedPreferences.getString(PreferencesHelper.planetList) ?? '';
  }

  Future<void> savedPlanetLaist({
    required String planetList,
  }) async {
    await _sharedPreferences.remove(PreferencesHelper.planetList);
    _planetList = planetList;
    await _sharedPreferences.setString(PreferencesHelper.planetList, planetList);
  }

  Future<void> removerPlanetLaist() async {
    _planetList = '';
    await _sharedPreferences.setString(PreferencesHelper.planetList, "");
  }
}
