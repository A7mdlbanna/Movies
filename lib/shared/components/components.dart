import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/shared/cubit/app_cubit.dart';

Widget moviesListBuilder(context){
  AppCubit cubit = AppCubit.get(context);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 250,
    child: ListView.separated(
      physics:const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.pushNamed(context, '/InfoScreen'),
        child: SizedBox(
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
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 20,),
      itemCount: 10,
    ),
  );
}

Widget actorsListBuilder(context){
  AppCubit cubit = AppCubit.get(context);
  return Container(
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
  );
}