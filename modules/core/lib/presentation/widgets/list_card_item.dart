import 'package:core/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

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
