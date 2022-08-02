import 'package:flutter/material.dart';
import 'package:movies_app/ui/resources/app_colors.dart';
import 'package:movies_app/ui/resources/app_images_path.dart';

Widget trailerButton(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        InkWell(
          child: Container(
            width: 140, height: 50,
            decoration: BoxDecoration(
              // gradient: Gradient(colors: [Color(0xFFD79C11), AppColors.yellow]),
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(40)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageIcon(const AssetImage(AppImage.playButtonIcon), color: AppColors.playButtonBG, size: 20,),
                Text('PLAY TRAILER', style: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),
        const SizedBox(width: 15,),
        InkWell(
          child: Container(
            width: 140, height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 2),
                borderRadius: BorderRadius.circular(40)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star, color: AppColors.yellow, size: 20,),
                Text('RATE MOVIE', style: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),

      ],
    ),
  );
}