import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TvShowDetailContent extends StatelessWidget {
  final TvShowDetail tvShow;
  final List<TvShow> tvShowRecommendations;
  final bool isAddedWatchlist;

  const TvShowDetailContent({
    Key? key,
    required this.tvShow,
    required this.tvShowRecommendations,
    required this.isAddedWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        CustomNetworkImage(
          imgUrl: '$baseImageUrlW500${tvShow.posterPath}',
          width: screenWidth,
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
                              tvShow.name,
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
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                            child: Text(
                              _showGenres(tvShow.genres),
                              style: kSubtitle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: Text(
                              _showReleaseDate(
                                tvShow.firstAirDate,
                                tvShow.lastAirDate,
                              ),
                              style: kSubtitle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RatingBarIndicator(
                                  rating: tvShow.voteAverage / 2,
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
                                  '${tvShow.voteAverage} (${tvShow.voteCount} votes)',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  children: <Text>[
                                    Text(
                                      '${tvShow.numberOfSeasons}',
                                      style: kHeading4,
                                    ),
                                    Text(
                                      'Total Season',
                                      style: kSubtitle.copyWith(
                                        color: kMikadoYellow,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 2,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                        offset: Offset(0.25, 0),
                                        blurRadius: 0.25,
                                        color: kDavysGrey,
                                      ),
                                      BoxShadow(
                                        offset: Offset(-0.25, 0),
                                        blurRadius: 0.25,
                                        color: kDavysGrey,
                                      ),
                                    ],
                                    color: kDavysGrey,
                                  ),
                                ),
                                Column(
                                  children: <Text>[
                                    Text(
                                      '${tvShow.numberOfEpisodes}',
                                      style: kHeading4,
                                    ),
                                    Text(
                                      'Total Episode',
                                      style: kSubtitle.copyWith(
                                        color: kMikadoYellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: _buildSeasonList(),
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
                            child: Text(
                              tvShow.overview,
                              style: const TextStyle(color: kDavysGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                          ),
                          Consumer<TvShowDetailNotifier>(
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
                                  child: _buildRecommendationList(),
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

  ListView _buildSeasonList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final season = tvShow.seasons[index];

        return SizedBox(
          width: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        CustomNetworkImage(
                          imgUrl: '$baseImageUrlW500${season.posterPath}',
                          placeHolderSize: 40,
                          width: 240,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black87, Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Text>[
                              Text(
                                'S${season.seasonNumber} ● ${season.episodeCount} Episodes',
                                style: kSubtitle,
                              ),
                              Text(
                                DateFormat('MMM dd, y')
                                    .format(DateTime.parse(season.airDate)),
                                style: const TextStyle(color: kDavysGrey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          season.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kSubtitle.copyWith(color: kMikadoYellow),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          season.overview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: kDavysGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: tvShow.seasons.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
    );
  }

  ListView _buildRecommendationList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final tvShow = tvShowRecommendations[index];

        return InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              TvShowDetailPage.routeName,
              arguments: tvShow.id,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomNetworkImage(
              imgUrl: '$baseImageUrlW300${tvShow.posterPath}',
              placeHolderSize: 40,
            ),
          ),
        );
      },
      itemCount: tvShowRecommendations.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
    );
  }

  Future<void> _onPressedWatchlistButton(BuildContext context) async {
    if (!isAddedWatchlist) {
      await Provider.of<TvShowDetailNotifier>(context, listen: false)
          .addTvShowToWatchlist(tvShow);
    } else {
      await Provider.of<TvShowDetailNotifier>(context, listen: false)
          .removeTvShowFromWatchlist(tvShow);
    }

    final message = Provider.of<TvShowDetailNotifier>(context, listen: false)
        .watchlistMessage;

    if (message == TvShowDetailNotifier.watchlistAddSuccessMessage ||
        message == TvShowDetailNotifier.watchlistRemoveSuccessMessage) {
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

  String _showReleaseDate(String firstAirDate, String lastAirDate) {
    final firstAirDateParse = firstAirDate.isEmpty
        ? '?'
        : DateFormat('MMM dd, y').format(DateTime.parse(firstAirDate));

    final lastAirDateParse = lastAirDate.isEmpty
        ? '?'
        : DateFormat('MMM dd, y').format(DateTime.parse(lastAirDate));

    return '$firstAirDateParse to $lastAirDateParse';
  }
}
