import 'package:flutter/material.dart';
import 'package:movies_app/ui/resources/app_colors.dart';
import 'package:readmore/readmore.dart';

Widget overView(info){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('STORY LINE', style: TextStyle(color: AppColors.navyBlueLight, fontWeight: FontWeight.bold, fontSize: 16),),
        const SizedBox(height: 10,),
        ReadMoreText(
          info.overview!,
          trimLines: 5,
          colorClickableText: AppColors.lightBlue,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          style: TextStyle(color: AppColors.white, fontSize: 17),
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.lightBlue),
        )
      ],
    ),
  );
}