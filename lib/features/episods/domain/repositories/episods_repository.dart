import 'package:dio/dio.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';

abstract class EpisodsRepository {
  ///RU: получение информации о всех эпизодах
  ///
  ///EN:getting the information of all episodes

  Future<EpisodsResult> getAllEpisods();

  Future<CharacterModel> getCharacter(
    String url,
    CancelToken? cancelToken,
  );
}
