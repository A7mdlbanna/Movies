import 'package:flutter/material.dart';
import 'package:movies_app/core/cubit/cubit.dart';

import '../../../core/constants.dart';
import '../../resources/app_colors.dart';


Widget trendingTypes(AppCubit cubit){
  return Container(
    height: 35,
    padding: const EdgeInsets.symmetric(horizontal: 20,),
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => InkWell(
        onTap: () => cubit.selectTrending(index),
        child: Container(
          // constraints: BoxConstraints.tightFor(width: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: cubit.selectedTrending[index] ? null : Border.all(color: AppColors.white, width: 2),
            gradient: cubit.selectedTrending[index] ? LinearGradient(colors: [AppColors.darkYellow, AppColors.yellow], ) : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(alignment: Alignment.center, child: Text(trendingCat[index], style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 12),)),
          ),
        ),
      ),
      itemCount: trendingCat.length, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
    ),
  );
}

Widget trendingDays(AppCubit cubit){
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () => cubit.selectTrendingDay(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: cubit.selectedTrendingDay[index] ? null : Border.all(color: AppColors.white, width: 2),
              gradient: cubit.selectedTrendingDay[index] ? LinearGradient(colors: [AppColors.darkYellow, AppColors.yellow], ) : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Align(alignment: Alignment.center, child: Text(trendingCatDay[index], style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 12),)),
            ),
          ),
        ),
        itemCount: trendingCatDay.length, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
      ),
    ),
  );
}