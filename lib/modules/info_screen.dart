import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/models/shows.dart' as show;

import '../shared/constants.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    show.Results info = arguments['movie_info'];
    print('info is ${info.title??info.name}');

    AppCubit cubit = AppCubit.get(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      backgroundColor: const Color(0xFF151C25),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
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
                  child: Image.network(
                    info.backdropPath!,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 30, left: 20,
                  child:  InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      CircleAvatar(backgroundColor: Colors.black54, radius: 16,),
                      ImageIcon(AssetImage('assets/icons/previous.png'), size: 16, color: Colors.white,),
                    ],
                  ),
                ),
                ),
                Positioned(
                  top: 30, right: 20,
                  child: IconButton(
                      onPressed: () {}, icon: const ImageIcon(AssetImage('assets/icons/search.png'), size: 30, color: Colors.white,)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: const Color(0xFFF4C110)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(cubit.getReleaseDate(info.releaseDate??info.firstAirDate!), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),),
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              RatingBar.builder(
                                itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber,),
                                unratedColor: const Color(0xFF5B6375),
                                onRatingUpdate: (rating) => cubit.changeRating(rating),
                                itemCount: 5,
                                itemSize: 20,
                                initialRating: 4.5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                ignoreGestures: true,
                              ),
                              const SizedBox(height: 5,),
                              Text(info.voteCount.toString(), style: const TextStyle(fontSize: 15, color: Color(0xFF5B6375), fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(width: 10,),
                          Text(getNumber(info.voteAverage).toString(), style: const TextStyle(fontSize: 40, color: Colors.white,),),
                        ],
                      ),
                      Text(info.name?? info.title!, style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const ImageIcon(AssetImage('assets/icons/clock (1).png'), color: Color(0xFFF4C110),size: 20,),
                  const SizedBox(width: 5,),
                  const Text('2h 13min', style: TextStyle(color: Colors.white, fontSize: 15),),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                          width: 60, height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFF292E3A)
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                              child: Text('Sci-Fi', style: TextStyle(color: Color(0xFFD9D7D7), fontSize: 15, fontWeight: FontWeight.w500),)),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(width: 10,),
                        itemCount: info.genreIds!.length,
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border, color: Colors.white, size: 30,))
                ],
              ),
            ),

            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                  Text('STORY LINE', style: TextStyle(color: Color(0xFF5B6375), fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: 10,),
                  Text('A mythic and emotionally charged hero\'s journey, "Dune" tells the story of Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, who must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet\'s exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity\'s greatest potential-only those who can conquer their fear will survive.—Warner Bros.', style: TextStyle(color: Color(0xFFD9D7D7), fontSize: 17), overflow: TextOverflow.ellipsis, maxLines: 5,),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      width: 140, height: 50,
                      decoration: BoxDecoration(
                        // gradient: Gradient(colors: [Color(0xFFD79C11), Color(0xFFF5C210)]),
                        color: const Color(0xFFF5C210),
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const[
                          ImageIcon(AssetImage('assets/icons/play-button.png'), color: Colors.black54, size: 20,),
                          Text('PLAY TRAILER', style: TextStyle(color: Color(
                              0xFFEAEAEA), fontSize: 14, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  InkWell(
                    child: Container(
                      width: 140, height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFEAEAEA), width: 2),
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const[
                          Icon(Icons.star, color: Color(0xFFF5C210), size: 20,),
                          Text('RATE MOVIE', style: TextStyle(color: Color(0xFFEAEAEA), fontSize: 14, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 20,),

            actorsListBuilder(context, title: 'ACTORS', people: cubit.people),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  const Text('ABOUT FILM', style: TextStyle(color: Color(0xFF5B6375), fontWeight: FontWeight.bold, fontSize: 18),),
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                       Text('Original Title:', style: TextStyle(color: Color(0xFF444759), fontWeight: FontWeight.bold, fontSize: 16),),
                       SizedBox(width: 12,),
                       Expanded(child: Text('Dune', style: TextStyle(color: Color(0xFFD9D7D7), fontSize: 16),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Type:', style: TextStyle(color: Color(0xFF444759), fontWeight: FontWeight.bold, fontSize: 16),),
                      SizedBox(width: 70,),
                      Expanded(child: Text('Sci-Fi', style: TextStyle(color: Color(0xFFD9D7D7), fontSize: 16),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Production:', style: TextStyle(color: Color(0xFF444759), fontWeight: FontWeight.bold, fontSize: 16),),
                      SizedBox(width: 25,),
                      Expanded(child: Text('United Kingdom, USA', style: TextStyle(color: Color(0xFFD9D7D7), fontSize: 16),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Premiere:', style: TextStyle(color: Color(0xFF444759), fontWeight: FontWeight.bold, fontSize: 16),),
                      SizedBox(width: 40,),
                      Expanded(child: Text('8 November 2016 (World)', style: TextStyle(color: Color(0xFFD9D7D7), fontSize: 16),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Description:', style: TextStyle(color: Color(0xFF444759), fontWeight: FontWeight.bold, fontSize: 16),),
                      SizedBox(width: 22,),
                      Expanded(child: Text('A noble family becomes embroiled in a war for control over the galaxy\'s most valuable asset while its heir becomes troubled by visions of a dark future.', style: TextStyle(color: Color(0xFFD9D7D7), fontSize: 16),)),
                    ],
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
            actorsListBuilder(context, title: 'CREATORS', people: cubit.people),
          ],
        ),
      ),
    );
  }
}
