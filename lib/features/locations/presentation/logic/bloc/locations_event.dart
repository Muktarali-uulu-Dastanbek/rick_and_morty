// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locations_bloc.dart';

@immutable
sealed class LocationsEvent {}

class GetAllLocations extends LocationsEvent {
  final int currentPage;
  final bool isFirstCall;

  GetAllLocations({
    required this.currentPage,
    this.isFirstCall = false,
  });
}

class GetAllCaharactersLocationInfo extends LocationsEvent {
  final List<String> characters;
  final CancelToken? cancelToken;

  GetAllCaharactersLocationInfo({
    required this.characters,
    this.cancelToken,
  });
}
