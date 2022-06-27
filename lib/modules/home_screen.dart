import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../shared/constants.dart';
import '../shared/cubit/app_cubit.dart';
import '../shared/cubit/app_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    selectedCategory[0] = true;
    CarouselController carouselController = CarouselController();
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              backgroundColor: const Color(0xFF151C25),
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color(0xFF151C25),
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const ImageIcon(AssetImage('assets/icons/list.png'), color: Color(0xFFEBECED), size: 40,),
                        onPressed: () {},
                      ),
                      const Text('Discover', style: TextStyle(color: Color(0xFFEBECED), fontSize: 23, fontWeight: FontWeight.w700),),
                      IconButton(
                          onPressed: () => cubit.changeSearchIcon(),
                          icon: ImageIcon(AssetImage(!cubit.isPressedSearchIcon ? 'assets/icons/search.png' : 'assets/icons/search2.png'), color: Color(0xFFEBECED), size: 30,)
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: 4,
                          itemBuilder: (context, index, idx) => Stack(
                            // alignment: Alignment.bottomLeft,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) {
                                  return const LinearGradient(
                                    colors: [Color(0xFF151C25), Colors.transparent],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.srcATop,
                                child: Image.asset(
                                  'assets/posters/dune.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 100),
                                  child: Text(
                                    'Dune 2021',
                                    style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 50, fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1,
                            viewportFraction: 1,
                            onPageChanged: (index, timed) => cubit.changeDotIndex(index),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: AnimatedSmoothIndicator(
                            activeIndex: cubit.dotIndex,
                            effect: const JumpingDotEffect(
                              dotColor: Color(0xFF434954),
                              activeDotColor: Color(0xFFF5C210),
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 15,
                            ),
                            count: 4,
                          ),
                        ),
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('TRENDING TODAY', style: TextStyle(color: Color(0xFF5B6375), fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 10,),
                    moviesListBuilder(context),

                    const SizedBox(height: 30,),

                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            border: selectedCategory[index] ? const Border(bottom: BorderSide(color: Color(0xFFF5B619), width: 4)) : null,
                          ),
                          child: TextButton(
                            onPressed: () => cubit.selectCategory(index),
                            child: Text('ACTION', style: TextStyle(fontSize: 15, fontWeight: selectedCategory[index] ? FontWeight.bold : FontWeight.w500, color: selectedCategory[index] ? const Color(0xFFFFFFFF) : const Color(0xFF4B5363)),)),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(width: 20,),
                        itemCount: 10
                      ),
                    ),
                    moviesListBuilder(context),

                    const SizedBox(height: 30,),
                    actorsListBuilder(context),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
