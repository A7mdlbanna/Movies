import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/cubit/cubit.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';
import 'package:movies_app/ui/resources/index.dart';

Widget actorsListBuilder(context, {String? title, required List<dynamic> people, isMovie = true}){
  AppCubit cubit = AppCubit.get(context);
  late List<dynamic> favList;
  switch(title){
    case null: favList = cubit.favTrendyActor; break;
    case AppStrings.bestActors: favList = cubit.favoriteActors; break;
    case AppStrings.actors: favList = isMovie ? cubit.favoriteMovieCast : cubit.favoriteTvCast; break;
    case AppStrings.creators: favList = isMovie ? cubit.favoriteMovieCrew : cubit.favoriteTvCrew; break;
  }
  ScrollController trendingController = ScrollController();
  if(title == AppStrings.bestActors) {
    trendingController.addListener(() {
      if(trendingController.position.pixels == trendingController.position.maxScrollExtent ){
        cubit.getPopularData(page: cubit.popularPeople!.page!+1);
      }
    });
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    color: title == AppStrings.bestActors ? AppColors.segmentDark : AppColors.segmentLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.heightBox,
        if(title != null)Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(title, style: TextStyle(color: AppColors.navyBlueLight, fontWeight: FontWeight.bold, fontSize: 16),),
            ),
          ],
        ),
        SizedBox(
          height: 210.h,
          child: ListView.separated(
            physics:const BouncingScrollPhysics(),
            controller: trendingController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SizedBox(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColors.primaryColor, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    ).createShader(bounds),
                    blendMode: BlendMode.srcATop,
                    child: Image(image: NetworkImage(people[index].profilePath??AppImage.nullPoster),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        switch(title){
                          case null: cubit.favTrendyPerson(index); break;
                          case AppStrings.bestActors: cubit.favActor(index); break;
                          case AppStrings.actors: isMovie ? cubit.favMovieCast(index, people.length) : cubit.favTvCast(index, people.length); break;
                          case AppStrings.creators: isMovie ? cubit.favMovieCrew(index, people.length) : cubit.favTvCrew(index, people.length); break;
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.black,
                            radius: 18,
                          ),
                          favList[index]
                              ? Icon(
                            Icons.favorite,
                            color: AppColors.red,
                          )
                              : Icon(
                            Icons.favorite_border_outlined,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 15, left: 10,
                      child: Text(people[index].name!, style: TextStyle(color: AppColors.white),)
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => 20.widthBox,
            itemCount: people.length,
          ),
        ),
        30.heightBox
      ],
    ),
  );
}