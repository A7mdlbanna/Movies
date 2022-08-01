import 'package:flutter/material.dart';
import 'package:movies_app/core/cubit/cubit.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';
import 'package:movies_app/ui/resources/app_colors.dart';
import 'package:movies_app/ui/widgets/home/categories_selection/popup_menu_item.dart';

import '../../../../core/constants.dart';

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
                  border: selectedCategory[index] ? Border(
                      bottom: BorderSide(color: AppColors.yellow,
                          width: 4)) : null,
                ),
                child: TextButton(
                    onPressed: () {
                      cubit.getCategoryMovies(category: cubit.moviesCategories[index].id, sorting: cubit.sorting);
                      cubit.selectCategory(index);
                    },
                    child: Text(cubit.moviesCategories[index].name!.toUpperCase(), style: TextStyle(fontSize: 12,
                        fontWeight: selectedCategory[index] ? FontWeight
                            .bold : FontWeight.w500,
                        color: selectedCategory[index] ? AppColors.white : AppColors.navyBlueLight),)),
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
      AssetImage(cubit.isPressedDown.contains(true) ? 'assets/icons/sort_down.png' : 'assets/icons/sort_up.png'),
      color: AppColors.navyBlueLight,
      size: 28,
    ),
    color: AppColors.navyBlueLight,
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      popUpMenuItem(cubit: cubit, index: 1, title: 'Name'),
      popUpMenuItem(cubit: cubit, index: 2, title: 'Popularity'),
      popUpMenuItem(cubit: cubit, index: 3, title: 'Rating'),
      popUpMenuItem(cubit: cubit, index: 4, title: 'Revenue'),
      popUpMenuItem(cubit: cubit, index: 5, title: 'vote count'),
    ],
    onSelected: (selected){
      switch(selected){
        case 'Name': cubit.getCategoryMovies(sorting: cubit.isPressedDown[0] ? 'original_title.desc' : 'original_title.acs', category: cubit.category); cubit.selectSort(0); break;
        case 'Popularity': cubit.getCategoryMovies(sorting: cubit.isPressedDown[1] ? 'popularity.asc' : 'popularity.desc', category: cubit.category); cubit.selectSort(1); break;
        case 'Rating': cubit.getCategoryMovies(sorting: cubit.isPressedDown[2] ? 'vote_average.asc' : 'vote_average.desc', category: cubit.category); cubit.selectSort(2); break;
        case 'Release date': cubit.getCategoryMovies(sorting: cubit.isPressedDown[3] ? 'release_date.asc' : 'release_date.desc', category: cubit.category); cubit.selectSort(3); break;
        case 'Revenue': cubit.getCategoryMovies(sorting: cubit.isPressedDown[4] ? 'revenue.asc' : 'revenue.desc', category: cubit.category); cubit.selectSort(4); break;
        case 'vote count': cubit.getCategoryMovies(sorting: cubit.isPressedDown[5] ? 'vote_count.asc' : 'vote_count.desc', category: cubit.category); cubit.selectSort(5); break;
      }
    },
  );
}