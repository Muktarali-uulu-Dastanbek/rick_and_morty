// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'episods_bloc.dart';

@immutable
sealed class EpisodsState {}

final class EpisodsInitialState extends EpisodsState {}

class EpisodsLoadingState extends EpisodsState {}

class EpisodsLoadedState extends EpisodsState {
  final EpisodsResult episodsResult;

  EpisodsLoadedState({required this.episodsResult});
}

class EpisodsErrorState extends EpisodsState {
  final CatchException error;

  EpisodsErrorState({required this.error});
}
