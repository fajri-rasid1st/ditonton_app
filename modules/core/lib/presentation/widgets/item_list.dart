import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

class ItemList extends StatelessWidget {
  final List<Movie>? movies;
  final List<TvShow>? tvShows;
  final double height;
  final double separatorWidth;
  final bool replaceRouteWhenItemTapped;

  const ItemList({
    Key? key,
    this.movies,
    this.tvShows,
    required this.height,
    required this.separatorWidth,
    this.replaceRouteWhenItemTapped = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeName = movies != null ? movieDetailRoute : tvShowDetailRoute;

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
            onTap: () {
              if (replaceRouteWhenItemTapped) {
                Navigator.pushReplacementNamed(
                  context,
                  routeName,
                  arguments: id,
                );
              } else {
                Navigator.pushNamed(
                  context,
                  routeName,
                  arguments: id,
                );
              }
            },
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
