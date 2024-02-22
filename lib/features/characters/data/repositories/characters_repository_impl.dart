import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';

import 'package:rick_and_morty/internal/helpers/api_requester.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

@Injectable(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<CharactersResult> getAllCharacters(int page) async {
    try {
      Response response = await apiRequester.toGet(
        'api/character',
        params: {"page": page},
      );
      // var dd ='{"info": { "count": 826,"pages": 42,"next": "https://rickandmortyapi.com/api/character?page=2","prev": null}}';
      // log('getAllUsers result == ${response.data}');

      if (response.statusCode == 200) {
        log("${response.statusCode}");
        // Map<String, dynamic> s = json.decode(dd);
        // var s = json.decode(dd);
        log("CHARACTERS result== ${response.data}");

        return CharactersResult.fromJson(response.data);
        // var s = jsonDecode(dd);
        // return s.map<CharactersResult>((g) => CharactersResult.fromJson(g));
        //.toList();
        // return response.data
        //     .map<CharactersResult>((g) => CharactersResult.fromJson(g))
        //     .toList();
      }

      throw response;
    } catch (e) {
      // ignore: avoid_print
      print('impl ======= $e');

      throw CatchException.convertException(e);
    }
  }

  @override
  Future<EpisodModel> getEpisod(String url) async {
    try {
      Response response = await apiRequester.toGet(url);
      if (response.statusCode == 200) {
        log("${response.statusCode}");
        log("EPISODES result== ${response.data}");

        return EpisodModel.fromJson(response.data, null);
      }

      throw response;
    } catch (e) {
      print('impl ======= $e');

      throw CatchException.convertException(e);
    }
  }
}
