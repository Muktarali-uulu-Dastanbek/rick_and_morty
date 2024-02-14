import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';

abstract class CharactersRepository {
  ///RU: получение информации о всех пользователях
  ///
  ///EN:getting the information of all users

  Future<CharactersResult> getAllCharacters(int page);
}
