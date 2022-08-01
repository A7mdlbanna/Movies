import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/cubit/cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../resources/app_colors.dart';

Widget moviesBanner(AppCubit cubit){
  CarouselController carouselController = CarouselController();
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      CarouselSlider.builder(
        carouselController: carouselController,
        itemCount: 5,
        itemBuilder: (context, index, idx) =>
            Stack(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.network(
                    cubit.popularMovies!.results![index].backdropPath!,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18,
                        vertical: 60),
                    child: Text(
                      cubit.popularMovies!.results![index].name??cubit.popularMovies!.results![index].title!,
                      style: TextStyle(color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 8),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.easeOutSine,
          viewportFraction: 1,
          onPageChanged: (index, any) =>
              cubit.changeDotIndex(index),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: AnimatedSmoothIndicator(
          activeIndex: cubit.dotIndex,
          effect: JumpingDotEffect(
            dotColor: AppColors.navyBlueLight,
            activeDotColor: AppColors.yellow,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 12,
          ),
          count: 5,
        ),
      ),
    ],
  );
}