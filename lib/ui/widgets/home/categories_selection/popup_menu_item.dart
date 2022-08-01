
import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';


PopupMenuEntry<String> popUpMenuItem({required cubit, required index, required title}){
  return PopupMenuItem(
    value: title,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: AppColors.white),),
        if(cubit.isPressedSort[index])ImageIcon(AssetImage(!cubit.isPressedDown[index]? 'assets/icons/up-arrow.png' : 'assets/icons/down-arrow.png'), color: AppColors.white, size: 15,)
      ],
    ),
  );
}