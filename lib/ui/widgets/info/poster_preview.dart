import 'package:flutter/material.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';
import 'package:movies_app/ui/resources/app_colors.dart';
import 'package:movies_app/ui/resources/app_images_path.dart';
import 'package:movies_app/ui/widgets/rating_bar.dart';

import '../../../core/cubit/cubit.dart';
import '../../../core/models/shows.dart' as show;
import '../../helper/app_date_formatter.dart';
import '../../helper/user_name_formatter.dart';


Widget posterPreview(show.Results info, context){
  AppCubit cubit = AppCubit.get(context);
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
              colors: [AppColors.primaryColor, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        child: Image.network(
          info.backdropPath!,
          fit: BoxFit.contain,
        ),
      ),
      Positioned(
        top: 30, left: 20,
        child:  InkWell(
          onTap: () => Navigator.pop(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(backgroundColor: AppColors.playButtonBG, radius: 16,),
              ImageIcon(const AssetImage(AppImage.backArrowIcon), size: 16, color: AppColors.white,),
            ],
          ),
        ),
      ),
      Positioned(
        top: 30, right: 20,
        child: IconButton(
            onPressed: () {}, icon: ImageIcon(const AssetImage(AppImage.searchFillIcon), size: 30, color: AppColors.white,)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.yellow
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppDateFormatter.getReleaseDate(info.releaseDate??info.firstAirDate!), style: TextStyle(fontSize: 18, color: AppColors.white, fontWeight: FontWeight.w500),),
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    ratingBar(20, info.voteAverage! / 2, cubit),
                    5.heightBox,
                    Text(info.voteCount.toString(), style: TextStyle(fontSize: 15, color: AppColors.navyBlueLight, fontWeight: FontWeight.bold)),
                  ],
                ),
                10.widthBox,
                Text(getNumber(info.voteAverage).toString(), style: TextStyle(fontSize: 40, color: AppColors.white,),),
              ],
            ),
            Text(info.name?? info.title!, style: TextStyle(fontSize: 20, color: AppColors.white, fontWeight: FontWeight.bold))
          ],
        ),
      )
    ],
  );
}