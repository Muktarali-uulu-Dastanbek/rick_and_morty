import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/characters/data%20/models/users_model.dart';
import 'package:rick_and_morty/features/characters/domain/presentation/user_repository.dart';

import 'package:rick_and_morty/internal/helpers/api_requester.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

@Injectable(as: UserRepository)
class UserRepositoriImpl implements UserRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<List<CharactersModel>> getAllCharacters() async {
    try {
      Response response = await apiRequester.toGet('api/character');
      // var dd ='{"info": { "count": 826,"pages": 42,"next": "https://rickandmortyapi.com/api/character?page=2","prev": null}}';
      var dd = '{"info": {"count": 826}}';
      // log('getAllUsers result == ${response.data}');

      if (response.statusCode == 200) {
        // Map<String, dynamic> s = json.decode(dd);
        // var s = json.decode(dd);
        var s = jsonDecode(dd);
        return s
            .map<CharactersModel>((g) => CharactersModel.fromJson(g));
            //.toList();
        // return response.data
        //     .map<CharactersModel>((g) => CharactersModel.fromJson(g))
        //     .toList();
      }

      throw response;
    } catch (e) {
      // ignore: avoid_print
      print('impl ======= $e');

      throw CatchException.convertException(e);
    }
  }
}
