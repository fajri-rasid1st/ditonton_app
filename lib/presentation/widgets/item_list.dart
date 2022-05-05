import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';

class ItemList extends StatelessWidget {
  final List<Movie>? movies;
  final List<TvShow>? tvShows;

  const ItemList({Key? key, this.movies, this.tvShows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemsLength = movies?.length ?? tvShows!.length;
    final routeName =
        movies != null ? MovieDetailPage.routeName : TvShowDetailPage.routeName;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final id = movies?[index].id ?? tvShows![index].id;
          final posterPath =
              movies?[index].posterPath ?? tvShows![index].posterPath;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                routeName,
                arguments: id,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomNetworkImage(
                  imgUrl: '$baseImageUrlW300$posterPath',
                  placeHolderSize: 40,
                ),
              ),
            ),
          );
        },
        itemCount: itemsLength,
      ),
    );
  }
}
