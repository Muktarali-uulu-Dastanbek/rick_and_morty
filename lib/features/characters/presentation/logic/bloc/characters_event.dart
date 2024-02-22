// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'characters_bloc.dart';

@immutable
sealed class CharactersEvent {}

class GetAllCharacters extends CharactersEvent {
  final int currentPage;
  final bool isFirstCall;

  GetAllCharacters({
    required this.currentPage,
    this.isFirstCall = false,
  });
}

class GetAllEpisodsInCharInfo extends CharactersEvent {
  final List<String> episode;

  GetAllEpisodsInCharInfo({required this.episode});
}
