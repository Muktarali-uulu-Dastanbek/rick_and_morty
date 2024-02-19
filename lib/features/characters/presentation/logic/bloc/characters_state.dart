part of 'characters_bloc.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitialState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final CharactersResult charactersResult;

  CharactersLoadedState({required this.charactersResult});
}

class CharactersErrorState extends CharactersState {
  final CatchException error;

  CharactersErrorState({required this.error});
}
