import 'dart:convert';
import 'dart:io';
import 'package:api_helper/api_helper.dart';
import 'package:either_dart/either.dart';

/// {@template example_resource}
/// An api resource to get the prompt terms.
/// {@endtemplate}
class PlanetResource {
  /// {@macro example_resource}
  PlanetResource({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  // ignore: unused_field
  final ApiClient _apiClient;

  /// Get /game/prompt/terms
  ///
  /// Returns a [List<String>].
  Future<Either<ApiException, PlanetModel>> getPlanet({
    Map<String, String>? headers,
  }) async {
    final response = await _apiClient.get(
      'planets',
      modifiedHeaders: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final loginResponse = PlanetModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      return Right(loginResponse);
    } else {
      return Left(
        ApiException(
          response.statusCode,
          response.body,
        ),
      );
    }
  }
}
