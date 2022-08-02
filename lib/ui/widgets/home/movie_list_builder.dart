import 'package:flutter/material.dart';
import 'package:movies_app/core/cubit/cubit.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';
import 'package:movies_app/ui/helper/navigator.dart';
import 'package:movies_app/ui/resources/app_routes.dart';
import 'package:movies_app/ui/widgets/rating_bar.dart';

import '../../helper/user_name_formatter.dart';
import '../../resources/app_colors.dart';

Widget moviesListBuilder(context, {bool isCategory = false, required List<dynamic> items}){
  AppCubit cubit = AppCubit.get(context);
  ScrollController trendingController = ScrollController();
  trendingController.addListener(() {
    if(trendingController.position.pixels == trendingController.position.maxScrollExtent ){
      cubit.getTrending(mediaType: cubit.mediaType, timeWindow: cubit.timeWindow, changeCat: false, page: cubit.trending!.page+1);
    }
  });
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 250,
    child: ListView.separated(
      physics:const BouncingScrollPhysics(),
      controller: trendingController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => pushNameWithArguments(context, AppRoutes.movieInfo, {'movie_info' : items[index]}),
          child: SizedBox(
            width: 135,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),child: Image(image: NetworkImage(items[index].posterPath??'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/movie-poster-template-design-21a1c803fe4ff4b858de24f5c91ec57f_screen.jpg?ts=1636996180'),))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3, top: 7),
                  child: Text(items[index].title??items[index].name!, style: TextStyle(color: AppColors.white), maxLines: 2, overflow: TextOverflow.ellipsis,),
                ),
                if(items[index].voteAverage != null)
                  Row(
                    children: [
                      Text('${getNumber(items[index].voteAverage, precision: 1)}', style: TextStyle(color: AppColors.white),),
                      10.widthBox,
                      ratingBar(15, items[index].voteAverage! / 2, cubit),
                    ],
                  )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => 20.widthBox,
      itemCount: items.length,
    ),
  );
}
