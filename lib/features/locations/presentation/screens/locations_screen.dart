import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';
import 'package:rick_and_morty/features/locations/presentation/logic/bloc/locations_bloc.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';
import 'package:rick_and_morty/internal/helpers/theme_helper.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  LocationsBloc locationsBloc = getIt<LocationsBloc>();
  late ScrollController _scrollController;
  bool isLoading = false;
  int currentPage = 1;
  List<LocationModel> locationsList = [];
  bool _theEnd = false;

  @override
  void initState() {
    locationsBloc.add(
      GetAllLocations(
        currentPage: currentPage,
        isFirstCall: true,
      ),
    );
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (locationsList.isNotEmpty) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // isLoading = true;

        if (isLoading) {
          currentPage = currentPage + 1;

          locationsBloc.add(
            GetAllLocations(
              currentPage: currentPage,
              isFirstCall: false,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF2F2F2),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 15.h,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                hintText: 'Найти локацию',
                hintStyle: TextHelper.hintText,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Icon(
                  Icons.filter_list_alt,
                  color: ThemeColor.hintTextCl,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<LocationsBloc, LocationsState>(
              bloc: locationsBloc,
              listener: (context, state) {
                if (state is LocationsLoadedState) {
                  locationsList.addAll(state.locationsResult.results ?? []);
                  if (locationsList.length <
                      state.locationsResult.info!.count!) {
                    isLoading = true;
                  } else {
                    isLoading = false;
                    setState(() {
                      _theEnd = true;
                    });
                  }
                }
                if (state is LocationsErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message.toString())));
                }
              },
              builder: (context, state) {
                if (state is LocationsLoadingState) {
                  return const CustomSpinner();
                }

                if (state is LocationsLoadedState) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "ВСЕГО ЛОКАЦИЙ: ${state.locationsResult.info?.count}"),
                            SizedBox(width: 14.w),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.zero,
                              itemCount: locationsList.length,
                              itemBuilder: (context, index) {
                                if (index >= locationsList.length - 1 &&
                                    !_theEnd) {
                                  return const CustomSpinner();
                                }
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/location_info',
                                      arguments:
                                          state.locationsResult.results?[index],
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 150.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.r),
                                              topRight: Radius.circular(10.r),
                                            ),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.r),
                                              topRight: Radius.circular(10.r),
                                            ),
                                            child: Image.asset(
                                              "${locationsList[index].locationImage}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(10.r),
                                            ),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${locationsList[index].name}",
                                                  style: TextHelper.s24w600,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "${locationsList[index].type} - ${locationsList[index].dimension}",
                                                  style: TextHelper.s12w400,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child:
          // Platform.isAndroid
          //     ? const CircularProgressIndicator()
          //     :
          CupertinoActivityIndicator(
        radius: 15.r,
        color: Colors.grey,
      ),
    );
  }
}
