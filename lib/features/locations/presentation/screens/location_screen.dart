import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/locations/presentation/logic/bloc/locations_bloc.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';
import 'package:rick_and_morty/internal/helpers/theme_helper.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<LocationScreen> {
  LocationsBloc locationsBloc = getIt<LocationsBloc>();

  @override
  void initState() {
    locationsBloc.add(GetAllLocations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              listener: (context, state) {},
              builder: (context, state) {
                if (state is Characters) {
                  return const CircularProgressIndicator();
                }

                if (state is LocationsLoadedState) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "ВСЕГО ЛОКАЦИЙ: ${state.locationsModel.info?.count}"),
                            SizedBox(width: 14.w),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: state.locationsModel.results!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/character_info');
                                  },
                                  child: Container(
                                    height: 210.h,
                                    width: 340.w,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 130.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.r),
                                                topRight: Radius.circular(10.r),
                                              ),
                                            ),
                                            child: Image.network(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS2IOVHn0jyOisQ8KFOSoCJrYVwEq7sXy4Og&usqp=CAU",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Text(
                                            "${state.locationsModel.results![index].name}",
                                            style: TextHelper.s24w700,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${state.locationsModel.results![index].type} - ${state.locationsModel.results![index].dimension}",
                                            style: TextHelper.s12w400,
                                          ),
                                        ],
                                      ),
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
