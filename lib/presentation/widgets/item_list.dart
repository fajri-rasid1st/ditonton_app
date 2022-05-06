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
  final double height;
  final double separatorWidth;

  const ItemList({
    Key? key,
    this.movies,
    this.tvShows,
    required this.height,
    required this.separatorWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeName =
        movies != null ? MovieDetailPage.routeName : TvShowDetailPage.routeName;

    final itemsLength = movies?.length ?? tvShows!.length;

    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final id = movies?[index].id ?? tvShows![index].id;
          final posterPath =
              movies?[index].posterPath ?? tvShows![index].posterPath;

          return InkWell(
            onTap: () => Navigator.pushNamed(context, routeName, arguments: id),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomNetworkImage(
                imgUrl: '$baseImageUrlW300$posterPath',
                placeHolderSize: 40,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: separatorWidth),
        itemCount: itemsLength,
      ),
    );
  }
}
