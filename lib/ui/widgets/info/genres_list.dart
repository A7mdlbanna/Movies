import 'package:flutter/material.dart';
import 'package:movies_app/ui/resources/app_colors.dart';

Widget genresList(info, cubit){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 40,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.genreColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text(cubit.getCatName(info, index) , style: TextStyle(color: AppColors.white, fontSize: 15, fontWeight: FontWeight.w500),)),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 10,),
      itemCount: info.genreIds!.length,
    ),
  );
}