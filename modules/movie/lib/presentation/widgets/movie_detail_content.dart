// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/movie.dart';
import 'package:readmore/readmore.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isWatchlist;

  const MovieDetailContent({
    Key? key,
    required this.movie,
    required this.recommendations,
    required this.isWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomNetworkImage(
          imgUrl: '$baseImageUrlW500${movie.posterPath}',
          placeHolderSize: 100,
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: kToolbarHeight + 32),
          child: DraggableScrollableSheet(
            snap: true,
            snapSizes: const [0.5],
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: kRichBlack,
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                            child: Text(
                              movie.title,
                              style: kHeading5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                            child: ElevatedButton.icon(
                              key: const Key('watchlist_button'),
                              onPressed: () {
                                _onPressedWatchlistButton(context);
                              },
                              icon: isWatchlist
                                  ? const Icon(Icons.check_rounded)
                                  : const Icon(Icons.add_rounded),
                              label: Text(
                                'Watchlist',
                                style: kSubtitle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                            child: Text(
                              _showGenres(movie.genres),
                              style: kSubtitle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: Text(_showDuration(movie.runtime)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemBuilder: (context, index) {
                                    return const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    );
                                  },
                                  itemCount: 5,
                                  itemSize: 24,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${movie.voteAverage} (${movie.voteCount} votes)',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Text(
                              'Overview',
                              style: kHeading6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: ReadMoreText(
                              movie.overview,
                              trimLines: 4,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...Show more',
                              trimExpandedText: 'Show less',
                              style: const TextStyle(color: kDavysGrey),
                              lessStyle: const TextStyle(color: Colors.white),
                              moreStyle: const TextStyle(color: Colors.white),
                              delimiter: ' ',
                            ),
                          ),
                          if (recommendations.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                              child: Text(
                                'Similar Movies',
                                style: kHeading6,
                              ),
                            ),
                            ItemList(
                              movies: recommendations,
                              height: 160,
                              separatorWidth: 12,
                              replaceRouteWhenItemTapped: true,
                            ),
                          ]
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: kDavysGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                tooltip: 'Back',
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onPressedWatchlistButton(BuildContext context) {
    if (isWatchlist) {
      context.read<MovieWatchlistBloc>().add(RemoveMovieWatchList(movie));
    } else {
      context.read<MovieWatchlistBloc>().add(InsertMovieWatchlist(movie));
    }
  }

  String _showGenres(List<Genre> genres) {
    String result = '';

    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) return result;

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) return '${hours}h ${minutes}m';

    return '${minutes}m';
  }
}
