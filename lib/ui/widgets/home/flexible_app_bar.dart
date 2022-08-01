import 'package:flutter/material.dart';

import '../../../core/cubit/cubit.dart';
import '../../resources/app_colors.dart';

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
            icon: ImageIcon(const AssetImage('assets/icons/list.png'), color: AppColors.white, size: 40,),
            onPressed: () {},
          ),
          Text(
            'Discover',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 23,
                fontWeight: FontWeight.w700),
          ),
          IconButton(
            onPressed: () => cubit.changeSearchIcon(),
            icon: ImageIcon(
              AssetImage(!cubit.isPressedSearchIcon
                  ? 'assets/icons/search.png'
                  : 'assets/icons/search2.png'),
              color: AppColors.white,
              size: 30,
            ),
          ),
        ],
      ),
    ),
  );
}
