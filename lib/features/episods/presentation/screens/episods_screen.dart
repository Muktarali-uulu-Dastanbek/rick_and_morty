import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/episods/presentation/logic/bloc/episods_bloc.dart';
import 'package:rick_and_morty/features/episods/presentation/widgets/episods_shimmer.dart';
import 'package:rick_and_morty/features/episods/presentation/widgets/episods_view.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';

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
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  hintText: 'Найти эпизод',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      // tabAlignment: TabAlignment.start,
                      // isScrollable: true,
                      // indicatorPadding: EdgeInsets.zero,
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      // labelColor: Colors.red,
                      labelStyle: Theme.of(context).textTheme.titleLarge,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(
                          text: "СЕЗОН 1",
                        ),
                        Tab(
                          text: "СЕЗОН 2",
                        ),
                      ],
                    ),
                    Container(
                      height: 588.h,
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
                            return EpisodsShimmer();
                          }
                          if (state is EpisodsLoadedState) {
                            var results = state.episodsResult.results;

                            return TabBarView(
                              children: [
                                EpisodsView(results: results),
                                EpisodsView(results: results),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
