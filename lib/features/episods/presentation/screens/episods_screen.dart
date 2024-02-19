import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/episods/presentation/logic/bloc/episods_bloc.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';

class EpisodsScreen extends StatefulWidget {
  const EpisodsScreen({super.key});

  @override
  State<EpisodsScreen> createState() => _EpisodsScreenState();
}

class _EpisodsScreenState extends State<EpisodsScreen> {
  EpisodsBloc episodsBloc = getIt<EpisodsBloc>();

  @override
  void initState() {
    episodsBloc.add(GetAllEpisodsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              hintText: 'Найти эпизод',
              hintStyle: TextHelper.hintText,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          DefaultTabController(
            length: 7,
            child: Column(
              children: [
                TabBar(
                  // labelPadding: EdgeInsets.zero,
                  // mouseCursor: MaterialStateMouseCursor.clickable,
                  // enableFeedback: false,
                  // dragStartBehavior: DragStartBehavior.start,
                  // physics:
                  //     ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  dividerColor: Colors.blue,
                  dividerHeight: 50,
                  isScrollable: true,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  labelStyle: TextHelper.w600s12,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      text: "СЕЗОН 1",
                    ),
                    Tab(
                      text: "СЕЗОН 2",
                    ),
                    Tab(
                      text: "СЕЗОН 3",
                    ),
                    Tab(
                      text: "СЕЗОН 4",
                    ),
                    Tab(
                      text: "СЕЗОН 5",
                    ),
                    Tab(
                      text: "СЕЗОН 6",
                    ),
                    Tab(
                      text: "СЕЗОН 7",
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 580.h,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: BlocConsumer<EpisodsBloc, EpisodsState>(
                        bloc: episodsBloc,
                        listener: (context, state) {
                          if (state is EpisodsErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.error.message.toString())));
                          }
                        },
                        builder: (context, state) {
                          if (state is EpisodsLoadingState) {
                            return CupertinoActivityIndicator(
                              radius: 15.r,
                              color: Colors.black,
                            );
                          }
                          if (state is EpisodsLoadedState) {
                            var results = state.episodsResult.results;

                            return TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: results!.length,
                                    itemBuilder: (context, index) {
                                      int i = Random().nextInt(6);
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/location_info',
                                          );
                                        },
                                        child: Container(
                                          height: 74.h,
                                          width: 300.w,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          // color: Colors.grey[300],
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 74.h,
                                                width: 74.w,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    "${results[index].episodImage}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 18.w),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "СЕРИЯ ${results[index].id}",
                                                    ),
                                                    Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      "${results[index].name}",
                                                      style: TextHelper.s13w400,
                                                    ),
                                                    Text(
                                                      "${results[index].airDate}",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Text("2"),
                                Text("3"),
                                Text("4"),
                                Text("5"),
                                Text("6"),
                                Text("7"),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
