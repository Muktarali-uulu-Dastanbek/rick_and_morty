// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';
import 'package:rick_and_morty/features/locations/domain/repositories/locations_repository.dart';

@injectable
class LocationsUseCase {
  final LocationsRepository locationsRepository;

  LocationsUseCase({required this.locationsRepository});

  Future<LocationsResult> getAllLocations(int page) async =>
      await locationsRepository.getAllLocations(page);

  Future<CharacterModel> getCharacter(
    String url,
    CancelToken? cancelToken,
  ) async {
    return await locationsRepository.getCharacter(
      url,
      cancelToken,
    );
  }
}
