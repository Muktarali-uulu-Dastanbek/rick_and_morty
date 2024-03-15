import 'package:dio/dio.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';

abstract class LocationsRepository {
  ///RU: получение информации о всех локации
  ///
  ///EN:getting the information of all locations

  Future<LocationsResult> getAllLocations(int page);

  Future<CharacterModel> getCharacter(
    String url,
    CancelToken? cancelToken,
  );
}
