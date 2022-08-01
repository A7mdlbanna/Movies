import 'package:flutter/cupertino.dart';
import 'package:movies_app/ui/helper/app_date_formatter.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';
import 'package:movies_app/ui/resources/app_colors.dart';

import '../../../../core/cubit/cubit.dart';
import 'info_row.dart';

Widget movieInfo(info, AppCubit cubit){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ABOUT FILM', style: TextStyle(color: AppColors.navyBlueLight, fontWeight: FontWeight.bold, fontSize: 18),),
        20.heightBox,

        infoRow('Original Title:', 12, info.originalTitle??info.originalName!,),
        10.heightBox,
        infoRow('Type:', 70, cubit.getCatsNames(info),),
        10.heightBox,
        infoRow('Production:', 25, 'United Kingdom, USA',),
        10.heightBox,
        infoRow('Premiere:', 40, AppDateFormatter.getFullReleaseDate(receive: info.firstAirDate??info.releaseDate!,),),
        10.heightBox,
        infoRow('Description:', 22, info.overview!,),
      ],
    ),
  );
}