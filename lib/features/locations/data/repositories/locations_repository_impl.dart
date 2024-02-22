import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';
import 'package:rick_and_morty/features/locations/domain/repositories/locations_repository.dart';
import 'package:rick_and_morty/internal/helpers/api_requester.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

@Injectable(as: LocationsRepository)
class LocationsRepositoriImpl implements LocationsRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<LocationsResult> getAllLocations(int page) async {
    try {
      Response response = await apiRequester.toGet(
        'api/location',
        params: {"page": page},
      );
      if (response.statusCode == 200) {
        log("${response.statusCode}");
        log("LOCATIONS result== ${response.data}");

        return LocationsResult.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('impl ======= $e');

      throw CatchException.convertException(e);
    }
  }
}
