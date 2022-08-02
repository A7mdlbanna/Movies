import 'package:flutter/cupertino.dart';
import 'package:movies_app/ui/helper/app_date_formatter.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';

import '../../../../core/cubit/cubit.dart';
import '../../../resources/index.dart';
import 'info_row.dart';

Widget movieInfo(info, AppCubit cubit){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.movieInfo, style: TextStyle(color: AppColors.navyBlueLight, fontWeight: FontWeight.bold, fontSize: 18),),
        20.heightBox,

        infoRow(AppStrings.movieTitle, 12, info.originalTitle??info.originalName!,),
        10.heightBox,
        infoRow(AppStrings.movieType, 70, cubit.getCatsNames(info),),
        10.heightBox,
        infoRow(AppStrings.movieProduction, 25, 'United Kingdom, USA',),
        10.heightBox,
        infoRow(AppStrings.moviePremiere, 40, AppDateFormatter.getFullReleaseDate(receive: info.firstAirDate??info.releaseDate!,),),
        10.heightBox,
        infoRow(AppStrings.movieDescription, 22, info.overview!,),
      ],
    ),
  );
}