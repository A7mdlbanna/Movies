import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/ui/resources/app_colors.dart';

Widget ratingBar(double iconSize, initialRating, cubit) {
  return RatingBar.builder(
    itemBuilder: (context, index) => Icon(
      Icons.star,
      color: AppColors.yellow,
    ),
    unratedColor: AppColors.navyBlueLight,
    onRatingUpdate: (rating) => cubit.changeRating(rating),
    itemCount: 5,
    itemSize: iconSize,
    initialRating: initialRating,
    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    ignoreGestures: true,
  );
}
