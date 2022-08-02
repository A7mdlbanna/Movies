import 'package:flutter/material.dart';

import '../../../core/cubit/cubit.dart';
import '../../resources/index.dart';

PreferredSizeWidget flexibleAppBar(AppCubit cubit) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: AppColors.primaryColor,
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: ImageIcon(const AssetImage(AppImage.list), color: AppColors.white, size: 40,),
            onPressed: () {},
          ),
          Text(
            AppStrings.discover,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 23,
                fontWeight: FontWeight.w700),
          ),
          IconButton(
            onPressed: () => cubit.changeSearchIcon(),
            icon: ImageIcon(
              AssetImage(!cubit.isPressedSearchIcon
                  ? AppImage.searchOutIcon
                  : AppImage.searchFillIcon),
              color: AppColors.white,
              size: 30,
            ),
          ),
        ],
      ),
    ),
  );
}
