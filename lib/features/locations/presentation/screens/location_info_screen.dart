import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';
import 'package:rick_and_morty/features/locations/presentation/logic/bloc/locations_bloc.dart';
import 'package:rick_and_morty/features/locations/presentation/widgets/location_info_appbar.dart';
import 'package:rick_and_morty/features/locations/presentation/widgets/location_info_shimmer.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/helpers/utils.dart';

class LocationInfoScreen extends StatefulWidget {
  final LocationModel locationModel;

  const LocationInfoScreen({super.key, required this.locationModel});

  @override
  State<LocationInfoScreen> createState() => _LocationInfoScreenState();
}

class _LocationInfoScreenState extends State<LocationInfoScreen> {
  LocationsBloc locationsBloc = getIt<LocationsBloc>();
  CancelToken? _cancelToken;

  @override
  void initState() {
    _cancelToken = CancelToken();
    locationsBloc.add(
      GetAllCaharactersLocationInfo(
        characters: widget.locationModel.residents!,
        cancelToken: _cancelToken,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken?.cancel("Вышел из экрана Локейшн Детейл");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<LocationsBloc, LocationsState>(
              bloc: locationsBloc,
              listener: (context, state) {
                if (state is LocationInfoErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message.toString())));
                }
              },
              builder: (context, state) {
                if (state is LocationInfoLoadingState) {
                  return const LocationInfoShimmer();
                }
                if (state is LocationInfoLoadedState) {
                  return CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: false,
                        delegate: LocationInfoAppBar(
                            location: widget.locationModel, widget: widget),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.characters.isNotEmpty
                              ? state.characters.length
                              : 1,
                          (BuildContext context, int index) {
                            return state.characters.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 16,
                                    ),
                                    // color: Colors.grey[300],
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 74.h,
                                          width: 74.w,
                                          decoration: const BoxDecoration(
                                            // color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipOval(
                                            child: Image.network(
                                              "${state.characters[index].image}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 18.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              statusConverter(state
                                                  .characters[index].status),
                                              style: TextStyle(
                                                color: statusColorConverter(
                                                    state.characters[index]
                                                        .status),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "${state.characters[index].name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            Text(
                                              "${speciesConverter(state.characters[index].species)}, ${genderConverter(state.characters[index].gender)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(
                                    child: Text(
                                      "Персонажов нет",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
