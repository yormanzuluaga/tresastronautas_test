import 'package:api_helper/api_helper.dart';
import 'package:api_repository/api_repository.dart';
import 'package:dartz/dartz.dart';

class PlanetRepositoryImpl extends PlanetRepository {
  PlanetResource planetResource;
  @override
  PlanetRepositoryImpl({
    required this.planetResource,
  });

  @override
  Future<Either<ApiException, PlanetModel>> getPlanet({
    Map<String, String>? headers,
  }) async {
    final movieModel = await planetResource.getPlanet(
      headers: headers,
    );
    return movieModel.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
