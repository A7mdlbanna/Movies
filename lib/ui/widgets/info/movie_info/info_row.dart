import 'package:flutter/cupertino.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';

import '../../../resources/app_colors.dart';

Widget infoRow(String title, double width, String body){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(color: AppColors.navyBlueLight, fontWeight: FontWeight.bold, fontSize: 16),),
      width.widthBox,
      Expanded(child: Text(body, style: TextStyle(color: AppColors.white, fontSize: 16),)),
    ],
  );
}