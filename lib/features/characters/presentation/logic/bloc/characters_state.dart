part of 'characters_bloc.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitialState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final CharactersResult characterModel;

  CharactersLoadedState({required this.characterModel});
}

class CharactersErrorState extends CharactersState {
  final CatchException error;

  CharactersErrorState({required this.error});
}
