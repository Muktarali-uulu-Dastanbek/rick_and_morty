// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/characters/data/repositories/characters_repository_impl.dart'
    as _i4;
import '../../features/characters/domain/repositories/characters_repository.dart'
    as _i3;
import '../../features/characters/domain/use_case/characters_use_case.dart'
    as _i5;
import '../../features/characters/presentation/logic/bloc/characters_bloc.dart'
    as _i12;
import '../../features/episods/data/repositories/episods_repository_impl.dart'
    as _i7;
import '../../features/episods/domain/repositories/episods_repository.dart'
    as _i6;
import '../../features/episods/domain/use_cases/episods_use_cases.dart' as _i8;
import '../../features/episods/presentation/logic/bloc/episods_bloc.dart'
    as _i13;
import '../../features/locations/data/repositories/locations_repository_impl.dart'
    as _i10;
import '../../features/locations/domain/repositories/locations_repository.dart'
    as _i9;
import '../../features/locations/domain/use_cases/locations_use_cases.dart'
    as _i11;
import '../../features/locations/presentation/logic/bloc/locations_bloc.dart'
    as _i14;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.CharactersRepository>(() => _i4.CharactersRepositoryImpl());
  gh.factory<_i5.CharactersUseCase>(() => _i5.CharactersUseCase(
      charactersRepository: gh<_i3.CharactersRepository>()));
  gh.factory<_i6.EpisodsRepository>(() => _i7.EpisodsRepositoryImpl());
  gh.factory<_i8.EpisodsUseCase>(
      () => _i8.EpisodsUseCase(episodsRepository: gh<_i6.EpisodsRepository>()));
  gh.factory<_i9.LocationsRepository>(() => _i10.LocationsRepositoriImpl());
  gh.factory<_i11.LocationsUseCase>(() => _i11.LocationsUseCase(
      locationsRepository: gh<_i9.LocationsRepository>()));
  gh.factory<_i12.CharactersBloc>(
      () => _i12.CharactersBloc(gh<_i5.CharactersUseCase>()));
  gh.factory<_i13.EpisodsBloc>(
      () => _i13.EpisodsBloc(gh<_i8.EpisodsUseCase>()));
  gh.factory<_i14.LocationsBloc>(
      () => _i14.LocationsBloc(gh<_i11.LocationsUseCase>()));
  return getIt;
}
