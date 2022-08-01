import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/cubit/cubit.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';

Widget actorsListBuilder(context, {String? title, required List<dynamic> people, isMovie = true}){
  AppCubit cubit = AppCubit.get(context);
  late List<dynamic> favList;
  switch(title){
    case null: favList = cubit.favTrendyActor; break;
    case 'BEST ACTORS': favList = cubit.favoriteActors; break;
    case 'ACTORS': favList = isMovie ? cubit.favoriteMovieCast : cubit.favoriteTvCast; break;
    case 'CREATORS': favList = isMovie ? cubit.favoriteMovieCrew : cubit.favoriteTvCrew; break;
  }
  ScrollController trendingController = ScrollController();
  trendingController.addListener(() {
    if(trendingController.position.pixels == trendingController.position.maxScrollExtent ){
      cubit.getTrending(mediaType: cubit.mediaType, timeWindow: cubit.timeWindow, changeCat: false, page: cubit.trending!.page+1);
    }
  });

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    color: title == 'BEST ACTORS' ? const Color(0xFF101418) : const Color(0xFF1E2634),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.heightBox,
        if(title != null)Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(title, style: const TextStyle(color: Color(0xFF5B6375), fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            const Spacer(),
            if(title == 'BEST ACTORS')
              TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5), // and this
                ),
                child: const Text(
                  'MORE ACTORS',
                  style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                ),
              ),
            if(title == 'CREATORS')
              TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5), // and this
                ),
                child: const Text(
                  'MORE CREATORS',
                  style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                ),
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
                    shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF151C25), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    ).createShader(bounds),
                    blendMode: BlendMode.srcATop,
                    child: Image(image: NetworkImage(people[index].profilePath??'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/movie-poster-template-design-21a1c803fe4ff4b858de24f5c91ec57f_screen.jpg?ts=1636996180'),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        switch(title){
                          case null: cubit.favTrendyPerson(index); break;
                          case 'BEST ACTORS': cubit.favActor(index); break;
                          case 'ACTORS': isMovie ? cubit.favMovieCast(index, people.length) : cubit.favTvCast(index, people.length); break;
                          case 'CREATORS': isMovie ? cubit.favMovieCrew(index, people.length) : cubit.favTvCrew(index, people.length); break;
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.black26,
                            radius: 18,
                          ),
                          favList[index]
                              ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                              : const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 15, left: 10,
                      child: Text(people[index].name!, style: const TextStyle(color: Colors.white),)
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