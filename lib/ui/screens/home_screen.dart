import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/cubit.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';
import 'package:movies_app/ui/resources/app_colors.dart';
import 'package:movies_app/ui/resources/app_strings.dart';
import 'package:movies_app/ui/widgets/home/categories_selection/categories_selection.dart';
import 'package:movies_app/ui/widgets/home/trending_selection.dart';

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../widgets/actor_list_builder.dart';
import '../widgets/home/flexible_app_bar.dart';
import '../widgets/home/home_banner.dart';
import '../widgets/home/movie_list_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: SystemUiOverlay.values);
    AppCubit cubit = AppCubit.get(context);
    cubit.selectedCategory[0] = cubit.isPressedSort[1] = cubit.isPressedDown[1] = cubit.selectedTrending[0] = true;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: flexibleAppBar(cubit),
        body:_homeScreenBody(context, cubit),
      );
      },
    );
  }

  Widget _homeScreenBody(BuildContext context, cubit) {
    return cubit.shows.isEmpty || cubit.people.isEmpty ? const Center(child: CircularProgressIndicator()): SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          moviesBanner(cubit),

          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('${AppStrings.trending} ${cubit.selectedTrendingDay[0] == true ? 'TODAY' : 'THIS WEEK'}', style: TextStyle(
                color: AppColors.navyBlueLight, fontWeight: FontWeight.bold),),
          ),
          15.heightBox,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              trendingTypes(cubit),
              10.widthBox,
              trendingDays(cubit),
              20.widthBox,
            ],
          ),
          15.heightBox,

          cubit.isPerson ? actorsListBuilder(context, title: null, people: cubit.trendyPPL, ) : moviesListBuilder(context, items: cubit.shows),

          30.heightBox,

          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                categoriesRow(cubit),
                categoriesSort(cubit),
              ],
            ),
          ),
          moviesListBuilder(context, items: cubit.catMovies),
          30.heightBox,

          actorsListBuilder(context, title: AppStrings.bestActors, people: cubit.people),
        ],
      ),
    );
  }
}
