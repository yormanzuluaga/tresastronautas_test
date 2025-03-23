import 'package:api_helper/api_helper.dart';
import 'package:dartz/dartz.dart';

abstract class PlanetRepository {
  Future<Either<ApiException, PlanetModel>> getPlanet({
    Map<String, String>? headers,
  });
}
