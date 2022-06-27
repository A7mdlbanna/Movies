import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const ImageIcon(AssetImage('assets/icons/list.png'), color: Color(0xFFEBECED), size: 40,),
                        onPressed: () {},
                      ),
                      const Text('Discover', style: TextStyle(color: Color(0xFFEBECED), fontSize: 23, fontWeight: FontWeight.w700),),
                      IconButton(
                          onPressed: () {},
                          icon: ImageIcon(AssetImage(cubit.isPressedSearchIcon ? 'assets/icons/search.png' : 'assets/icons/search2.png'), color: Color(0xFFEBECED), size: 30,)
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
                                  'assets/dune.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 70),
                                  child: Text(
                                    'Dune 2021',
                                    style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 35, fontWeight: FontWeight.w500),
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

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 250,
                      child: ListView.separated(
                        physics:const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => SizedBox(
                          width: 135,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: Image(image: AssetImage('assets/posters/full_dune.png'),)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 3, top: 7),
                                child: Text('Dune', style: TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.fade,),
                              ),
                              Row(
                                children: [
                                  Text('${cubit.rating}', style: const TextStyle(color: Colors.white),),
                                  const SizedBox(width: 10,),
                                  RatingBar.builder(
                                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber,),
                                    unratedColor: const Color(0xFF5B6375),
                                    onRatingUpdate: (rating) => cubit.changeRating(rating),
                                    itemCount: 5,
                                    itemSize: 15,
                                    initialRating: 4.5,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                    ignoreGestures: true,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(width: 20,),
                        itemCount: 5,
                      ),
                    ),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 250,
                      child: ListView.separated(
                        physics:const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => SizedBox(
                          width: 135,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: Image(image: AssetImage('assets/posters/full_dune.png'),)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 3, top: 7),
                                child: Text('Dune', style: TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.fade,),
                              ),
                              Row(
                                children: [
                                  Text('${cubit.rating}', style: const TextStyle(color: Colors.white),),
                                  const SizedBox(width: 10,),
                                  RatingBar.builder(
                                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber,),
                                    unratedColor: const Color(0xFF5B6375),
                                    onRatingUpdate: (rating) => cubit.changeRating(rating),
                                    itemCount: 5,
                                    itemSize: 15,
                                    initialRating: 4.5,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                    ignoreGestures: true,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(width: 20,),
                        itemCount: 5,
                      ),
                    ),

                    const SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: const Color(0xFF101418),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              const Text('BEST ACTORS', style: const TextStyle(color: Color(0xFF5B6375), fontWeight: FontWeight.bold),),
                              const Spacer(),
                              TextButton(
                                onPressed: (){},
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5), // and this
                                ),
                                child: const Text(
                                  'MORE ACTORS',
                                  style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 210,
                            child: ListView.separated(
                              physics:const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => SizedBox(
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) => const LinearGradient(
                                        colors: [Color(0xFF151C25), Colors.transparent],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter
                                      ).createShader(bounds),
                                      blendMode: BlendMode.srcATop,
                                      child: const Image(image: AssetImage('assets/actors/oscar.jpg'),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.favActor(index);
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const CircleAvatar(
                                              backgroundColor: Colors.black26,
                                              radius: 18,
                                            ),
                                            cubit.favoriteActors[index]
                                                ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                                : const Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.white70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 15, left: 10,
                                        child: Text('Oscar Isaac', style: TextStyle(color: Colors.white),)
                                    ),
                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) => const SizedBox(width: 20,),
                              itemCount: 5,
                            ),
                          ),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
