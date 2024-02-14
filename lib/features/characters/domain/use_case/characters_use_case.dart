import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

@injectable
class CharactersUseCase {
  final CharactersRepository charactersRepository;

  CharactersUseCase({required this.charactersRepository});

  Future<CharactersResult> getAllCharacters(int page) async {
    return await charactersRepository.getAllCharacters(page);
  }
}
