// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/episods/data/models/episods_model.dart';
import 'package:rick_and_morty/features/episods/domain/repositories/episods_repository.dart';

@injectable
class EpisodsUseCase {
  final EpisodsRepository episodsRepository;

  EpisodsUseCase({required this.episodsRepository});

  Future<EpisodsResult> getAllEpisods() async {
    return await episodsRepository.getAllEpisods();
  }
}
