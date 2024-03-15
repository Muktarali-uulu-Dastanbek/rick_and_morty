part of 'episods_bloc.dart';

@immutable
sealed class EpisodsEvent {}

class GetAllEpisodsEvent extends EpisodsEvent {}

class GetAllCaharactersEpisodInfo extends EpisodsEvent {
  final List<String> characters;
  final CancelToken? cancelToken;

  GetAllCaharactersEpisodInfo({
    required this.characters,
    this.cancelToken,
  });
}