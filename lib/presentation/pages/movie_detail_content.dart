import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const MovieDetailContent({
    Key? key,
    required this.movie,
    required this.recommendations,
    required this.isAddedWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        CustomNetworkImage(
          imgUrl: '$baseImageUrlW500${movie.posterPath}',
          width: screenWidth,
          placeHolderSize: 100,
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            snap: true,
            snapSizes: const [0.5],
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: kRichBlack,
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.only(top: 32, bottom: 16),
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
                              onPressed: () async {
                                await _onPressedWatchlistButton(context);
                              },
                              icon: isAddedWatchlist
                                  ? const Icon(Icons.check_rounded)
                                  : const Icon(Icons.add_rounded),
                              label: Text(
                                'Watchlist',
                                style: kSubtitle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(_showGenres(movie.genres)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                            child: Text(_showDuration(movie.runtime)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Row(
                              children: <Widget>[
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    );
                                  },
                                  itemSize: 24,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${movie.voteAverage}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                            child: Text(
                              'Overview',
                              style: kHeading6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Text(movie.overview),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                          ),
                          Consumer<MovieDetailNotifier>(
                            builder: (context, provider, child) {
                              final state = provider.recommendationState;

                              if (state == RequestState.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state == RequestState.error) {
                                return Center(
                                  child: Text(provider.message),
                                );
                              } else if (state == RequestState.loaded) {
                                return SizedBox(
                                  height: 160,
                                  child: _buildRecommendationsList(),
                                );
                              }

                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
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
        Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        )
      ],
    );
  }

  ListView _buildRecommendationsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final movie = recommendations[index];

        return InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              MovieDetailPage.routeName,
              arguments: movie.id,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomNetworkImage(
              imgUrl: '$baseImageUrlW300${movie.posterPath}',
              placeHolderSize: 40,
            ),
          ),
        );
      },
      itemCount: recommendations.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
    );
  }

  Future<void> _onPressedWatchlistButton(BuildContext context) async {
    if (!isAddedWatchlist) {
      await Provider.of<MovieDetailNotifier>(context, listen: false)
          .addMovieToWatchlist(movie);
    } else {
      await Provider.of<MovieDetailNotifier>(context, listen: false)
          .removeMovieFromWatchlist(movie);
    }

    final message = Provider.of<MovieDetailNotifier>(context, listen: false)
        .watchlistMessage;

    if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
        message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
      final SnackBar snackBar = SnackBar(
        content: Text(
          message,
          style: kDefaultText,
        ),
        backgroundColor: kMikadoYellow,
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text(message)),
      );
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