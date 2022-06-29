import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../shared/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../../models/People/PopularPeople.dart' as person;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: SystemUiOverlay.values);
    selectedCategory[0] = true;
    cubit.isPressedSort[1] = true;
    cubit.isPressedDown[1] = true;
    cubit.selectedTrending[0] = true;

    CarouselController carouselController = CarouselController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) =>
      Scaffold(
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
                  icon: const ImageIcon(
                    AssetImage('assets/icons/list.png'), color: Color(0xFFEBECED),
                    size: 40,),
                  onPressed: () {},
                ),
                const Text('Discover', style: TextStyle(color: Color(0xFFEBECED),
                    fontSize: 23,
                    fontWeight: FontWeight.w700),),
                IconButton(               onPressed: () => cubit.changeSearchIcon(),
                    icon: ImageIcon(AssetImage(!cubit.isPressedSearchIcon
                        ? 'assets/icons/search.png'
                        : 'assets/icons/search2.png'), color: const Color(0xFFEBECED),
                      size: 30,)
                ),
              ],
            ),
          ),
        ),
        body: cubit.shows.isEmpty || cubit.people.isEmpty ? const Center(child: CircularProgressIndicator()): SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: 5,
                    itemBuilder: (context, index, idx) =>
                        Stack(
                          // alignment: Alignment.bottomLeft,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return const LinearGradient(
                                    colors: [
                                      Color(0xFF151C25),
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
                                  style: const TextStyle(color: Color(0xFFF5F5F5),
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
                      effect: const JumpingDotEffect(
                        dotColor: Color(0xFF434954),
                        activeDotColor: Color(0xFFF5C210),
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 12,
                      ),
                      count: 5,
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('TRENDING TODAY', style: TextStyle(
                    color: Color(0xFF5B6375), fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 15,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                              border: cubit.selectedTrending[index] ? null : Border.all(color: const Color(0xFFEBECED), width: 2),
                              gradient: cubit.selectedTrending[index] ? const LinearGradient(colors: [Color(0xFFFF9900), Color(0xFFEFC842)], ) : null,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Align(alignment: Alignment.center, child: Text(trendingCat[index], style: const TextStyle(color: Color(0xFFEBECED), fontWeight: FontWeight.w500, fontSize: 12),)),
                            ),
                          ),
                      ),
                      itemCount: trendingCat.length, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
                    ),
                  ),
                  // const Spacer(),
                  const SizedBox(height: 10,),
                  Align(
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
                            // constraints: BoxConstraints.tightFor(width: 80),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: cubit.selectedTrendingDay[index] ? null : Border.all(color: const Color(0xFFEBECED), width: 2),
                                gradient: cubit.selectedTrendingDay[index] ? const LinearGradient(colors: [Color(0xFFFF9900), Color(0xFFEFC842)], ) : null,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Align(alignment: Alignment.center, child: Text(trendingCatDay[index], style: const TextStyle(color: Color(0xFFEBECED), fontWeight: FontWeight.w500, fontSize: 12),)),
                              ),
                            ),
                        ),
                        itemCount: trendingCatDay.length, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,)
                ],
              ),
              const SizedBox(height: 15,),

              isPerson ? actorsListBuilder(context, title: null, people: cubit.trendyPPL, ) : moviesListBuilder(context, items: cubit.shows),

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  children: [
                    Expanded(
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
                                    border: selectedCategory[index] ? const Border(
                                        bottom: BorderSide(color: Color(0xFFF5B619),
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
                                          color: selectedCategory[index] ? const Color(0xFFFFFFFF) : const Color(0xFF4B5363)),)),
                                ),
                            separatorBuilder: (context, index) =>
                            const SizedBox(width: 10,),
                            itemCount: cubit.moviesCategories.length
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: ImageIcon(
                        AssetImage(cubit.isPressedDown.contains(true) ? 'assets/icons/sort_down.png' : 'assets/icons/sort_up.png'),
                        color: const Color(0xFF4B5363),
                        size: 28,
                      ),
                      color: const Color(0xFF4B5363),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem(
                            value: 'Name',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const Text('Name', style: TextStyle(color: Color(0xFFEAEAEA)),),
                              if(cubit.isPressedSort[0])ImageIcon(AssetImage(!cubit.isPressedDown[0]? 'assets/icons/up-arrow.png' : 'assets/icons/down-arrow.png'), color: const Color(0xFFEAEAEA), size: 15,)
                            ],
                          ),),
                        PopupMenuItem(
                            value: 'Popularity',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const Text('Popularity', style: TextStyle(color: Color(0xFFEAEAEA)),),
                              if(cubit.isPressedSort[1])ImageIcon(AssetImage(!cubit.isPressedDown[1]? 'assets/icons/up-arrow.png' : 'assets/icons/down-arrow.png'), color: const Color(0xFFEAEAEA), size: 15,),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                            value: 'Rating',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const Text('Rating', style: TextStyle(color: Color(0xFFEAEAEA)),),
                              if(cubit.isPressedSort[2])ImageIcon(AssetImage(!cubit.isPressedDown[2]? 'assets/icons/up-arrow.png' : 'assets/icons/down-arrow.png'), color: const Color(0xFFEAEAEA), size: 15,),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                            value: 'Release date',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const Text('Release date', style: TextStyle(color: Color(0xFFEAEAEA)),),
                              if(cubit.isPressedSort[3])ImageIcon(AssetImage(!cubit.isPressedDown[3]? 'assets/icons/up-arrow.png' : 'assets/icons/down-arrow.png'), color: const Color(0xFFEAEAEA), size: 15,)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                            value: 'Revenue',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const Text('Revenue', style: TextStyle(color: Color(0xFFEAEAEA)),),
                              if(cubit.isPressedSort[4])ImageIcon(AssetImage(!cubit.isPressedDown[4]? 'assets/icons/up-arrow.png' : 'assets/icons/down-arrow.png'), color: const Color(0xFFEAEAEA), size: 15,),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                            value: 'vote count',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const Text('vote count', style: TextStyle(color: Color(0xFFEAEAEA)),),
                              if(cubit.isPressedSort[5])ImageIcon(AssetImage(!cubit.isPressedDown[5]? 'assets/icons/up-arrow.png' : 'assets/icons/down-arrow.png'), color: const Color(0xFFEAEAEA), size: 15,),
                            ],
                          ),
                        ),
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
                    ),
                  ],
                ),
              ),
              moviesListBuilder(context, items: cubit.catMovies),
              const SizedBox(height: 30,),

              actorsListBuilder(context, title: 'BEST ACTORS', people: cubit.people),
            ],
          ),
        ),
      ),
    );
  }
}
