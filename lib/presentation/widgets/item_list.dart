import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/domain/entities/movie_entities/movie.dart';

class ItemList extends StatelessWidget {
  final List<Movie> movies;

  const ItemList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomNetworkImage(
                  imgUrl: '$baseImageUrlW300${movie.posterPath}',
                  placeHolderSize: 40,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
