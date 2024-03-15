// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'characters_bloc.dart';

@immutable
sealed class CharactersEvent {}

class GetAllCharacters extends CharactersEvent {
  final int currentPage;
  final bool isFirstCall;
  final CancelToken? cancelToken;

  GetAllCharacters({
    required this.currentPage,
    this.isFirstCall = false,
    this.cancelToken,
  });
}

class GetAllEpisodsCharecterInfo extends CharactersEvent {
  final List<String> episods;
  final CancelToken? cancelToken;

  GetAllEpisodsCharecterInfo({
    required this.episods,
    this.cancelToken,
  });
}
