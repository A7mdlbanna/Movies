import 'package:flutter/material.dart';
import 'package:movies_app/core/cubit/cubit.dart';
import 'package:movies_app/ui/widgets/home/categories_selection/popup_menu_item.dart';

import '../../../helper/index.dart';
import '../../../resources/index.dart';

Widget categoriesRow(AppCubit cubit){
  return Expanded(
    child: Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  border: cubit.selectedCategory[index] ? Border(
                      bottom: BorderSide(color: AppColors.yellow,
                          width: 4)) : null,
                ),
                child: TextButton(
                    onPressed: () {
                      cubit.getCategoryMovies(category: cubit.moviesCategories[index].id, sorting: cubit.sorting);
                      cubit.selectCategory(index);
                    },
                    child: Text(cubit.moviesCategories[index].name!.toUpperCase(), style: TextStyle(fontSize: 12,
                        fontWeight: cubit.selectedCategory[index] ? FontWeight
                            .bold : FontWeight.w500,
                        color: cubit.selectedCategory[index] ? AppColors.white : AppColors.navyBlueLight),)),
              ),
          separatorBuilder: (context, index) =>
          10.widthBox,
          itemCount: cubit.moviesCategories.length
      ),
    ),
  );
}

Widget categoriesSort(AppCubit cubit){
  return PopupMenuButton(
    icon: ImageIcon(
      AssetImage(cubit.isPressedDown.contains(true) ? AppImage.sortDownIcon : AppImage.sortUpIcon),
      color: AppColors.navyBlueLight,
      size: 28,
    ),
    color: AppColors.navyBlueLight,
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      popUpMenuItem(cubit: cubit, index: 0, title: AppStrings.sortName),
      popUpMenuItem(cubit: cubit, index: 1, title: AppStrings.sortPopularity),
      popUpMenuItem(cubit: cubit, index: 2, title: AppStrings.sortRating),
      popUpMenuItem(cubit: cubit, index: 3, title: AppStrings.sortRelease),
      popUpMenuItem(cubit: cubit, index: 4, title: AppStrings.sortRevenue),
      popUpMenuItem(cubit: cubit, index: 5, title: AppStrings.sortVotes),
    ],
    onSelected: (selected){
      switch(selected){
        case AppStrings.sortName: updateBasedOnSort(0, AppStrings.originalTitleDesc, AppStrings.originalTitleAsc, cubit); cubit.selectSort(0); break;
        case AppStrings.sortPopularity: updateBasedOnSort(1, AppStrings.popularityAsc, AppStrings.popularityDesc, cubit); cubit.selectSort(0); break;
        case AppStrings.sortRating: updateBasedOnSort(2, AppStrings.voteAverageAsc, AppStrings.voteAverageDesc, cubit); cubit.selectSort(0); break;
        case AppStrings.sortRelease: updateBasedOnSort(3, AppStrings.releaseDateAsc, AppStrings.releaseDateDesc, cubit); cubit.selectSort(0); break;
        case AppStrings.sortRevenue: updateBasedOnSort(4, AppStrings.revenueAsc, AppStrings.revenueDesc, cubit); cubit.selectSort(0); break;
        case AppStrings.sortVotes: updateBasedOnSort(5, AppStrings.voteCountAsc, AppStrings.voteCountDesc, cubit); cubit.selectSort(0); break;
      }
    },
  );
}

void updateBasedOnSort(index, sortA, sortB, AppCubit cubit){
  cubit.getCategoryMovies(
      sorting: cubit.isPressedDown[index]
          ? sortA
          : sortB,
      category: cubit.category);
}