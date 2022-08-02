
import 'package:flutter/material.dart';
import '../../../resources/index.dart';


PopupMenuEntry<String> popUpMenuItem({required cubit, required index, required title}){
  return PopupMenuItem(
    value: title,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: AppColors.white),),
        if(cubit.isPressedSort[index])ImageIcon(AssetImage(!cubit.isPressedDown[index]? AppImage.upArrowIcon : AppImage.downArrowIcon), color: AppColors.white, size: 15,)
      ],
    ),
  );
}