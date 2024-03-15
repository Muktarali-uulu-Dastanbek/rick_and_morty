import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';
import 'package:rick_and_morty/features/episods/domain/repositories/episods_repository.dart';
import 'package:rick_and_morty/internal/helpers/api_requester.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

@Injectable(as: EpisodsRepository)
class EpisodsRepositoryImpl implements EpisodsRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<EpisodsResult> getAllEpisods() async {
    try {
      Response response = await apiRequester.toGet('api/episode');
      if (response.statusCode == 200) {
        log("${response.statusCode}");
        log("EPISODES result== ${response.data}");

        return EpisodsResult.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('impl ======= $e');

      throw CatchException.convertException(e);
    }
  }

  @override
  Future<CharacterModel> getCharacter(
    String url,
    CancelToken? cancelToken,
  ) async {
    try {
      Response response = await apiRequester.toGet(
        url,
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        log("${response.statusCode}");
        log("CHARACTER result== ${response.data}");

        return CharacterModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('impl ======= $e');

      throw CatchException.convertException(e);
    }
  }
}
