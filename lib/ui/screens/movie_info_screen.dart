import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/helper/app_size_boxes.dart';
import 'package:movies_app/ui/resources/app_colors.dart';
import 'package:movies_app/ui/resources/app_images_path.dart';
import 'package:movies_app/ui/resources/app_strings.dart';
import 'package:movies_app/ui/widgets/info/genres_list.dart';
import 'package:movies_app/ui/widgets/info/overView.dart';
import 'package:movies_app/ui/widgets/info/poster_preview.dart';
import 'package:movies_app/ui/widgets/info/trailer_button.dart';

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../../core/models/shows.dart' as show;
import '../widgets/actor_list_builder.dart';
import '../widgets/info/movie_info/movie_info.dart';


class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({Key? key}) : super(key: key);

  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    AppCubit cubit = AppCubit.get(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    show.Results info = arguments['movie_info'];
    info.mediaType == AppStrings.movie? cubit.getMovieCredits(movieId: info.id) : cubit.getTvCredits(tvId: info.id);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bool load = info.mediaType == AppStrings.movie? (cubit.movieCast.isEmpty || cubit.movieCrew.isEmpty) : (cubit.tvCast.isEmpty || cubit.tvCrew.isEmpty);
        return load
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  posterPreview(info, context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ImageIcon(const AssetImage(AppImage.clockIcon), color: AppColors.yellow,size: 20,),
                        5.widthBox,
                        Text('2h 13min', style: TextStyle(color: AppColors.white, fontSize: 15),),
                        const Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border, color: AppColors.white, size: 30,))
                      ],
                    ),
                  ),
                  genresList(info, cubit),
                  20.heightBox,

                  overView(info),
                  20.heightBox,

                  trailerButton(),
                  20.heightBox,

                  actorsListBuilder(context, title: AppStrings.actors, people: info.mediaType == AppStrings.movie ? cubit.movieCredits!.cast! : cubit.tvCredits!.cast!, isMovie: info.mediaType == AppStrings.movie),

                  movieInfo(info, cubit),
                  actorsListBuilder(context, title: AppStrings.creators, people: info.mediaType == AppStrings.movie ? cubit.movieCredits!.crew! : cubit.tvCredits!.crew!, isMovie: info.mediaType == AppStrings.movie),
                ],
              ),
            )
        );
        },
    );
  }
}
