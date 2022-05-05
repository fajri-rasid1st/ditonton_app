import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';

class SliverListCardItem extends StatelessWidget {
  final List<Movie>? movies;
  final List<TvShow>? tvShows;

  const SliverListCardItem({
    Key? key,
    this.movies,
    this.tvShows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemsLength = movies?.length ?? tvShows!.length;

    return Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final hasSeparator = index != itemsLength - 1;
                    final bottom = hasSeparator ? 8.0 : 0.0;

                    return Padding(
                      padding: EdgeInsets.only(bottom: bottom),
                      child: CardItem(
                        movie: movies?[index],
                        tvShow: tvShows?[index],
                      ),
                    );
                  },
                  childCount: itemsLength,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
