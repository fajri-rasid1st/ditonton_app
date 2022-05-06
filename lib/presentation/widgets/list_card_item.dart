import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';

class ListCardItem extends StatelessWidget {
  final List<Movie>? movies;
  final List<TvShow>? tvShows;

  const ListCardItem({Key? key, this.movies, this.tvShows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemsLength = movies?.length ?? tvShows!.length;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) {
        return CardItem(
          movie: movies?[index],
          tvShow: tvShows?[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: itemsLength,
    );
  }
}
