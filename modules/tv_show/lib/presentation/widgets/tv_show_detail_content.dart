import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:tv_show/tvshow.dart';

class TvShowDetailContent extends StatelessWidget {
  final TvShowDetail tvShow;
  final List<TvShow> recommendations;
  final bool isWatchlist;

  const TvShowDetailContent({
    Key? key,
    required this.tvShow,
    required this.recommendations,
    required this.isWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomNetworkImage(
          imgUrl: '$baseImageUrlW500${tvShow.posterPath}',
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
                              tvShow.name,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            child: ReadMoreText(
                              tvShow.overview,
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
                                'Similar Tv Shows',
                                style: kHeading6,
                              ),
                            ),
                            ItemList(
                              tvShows: recommendations,
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

  ListView _buildSeasonList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final season = tvShow.seasons.reversed.toList()[index];

        return SizedBox(
          width: 240,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    if (season.seasonNumber != 0) {
                      Navigator.pushNamed(
                        context,
                        tvShowSeasonDetailRoute,
                        arguments: TvShowSeasonDetailArgs(tvShow.id, season),
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        CustomNetworkImage(
                          imgUrl: '$baseImageUrlW500${season.posterPath}',
                          width: 240,
                          placeHolderSize: 40,
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
                        ListTile(
                          title: Text(
                            'S${season.seasonNumber} ● ${season.episodeCount} Episodes',
                            style: kSubtitle,
                          ),
                          subtitle: season.seasonNumber != 0
                              ? Row(
                                  children: const <Widget>[
                                    Text(
                                      'Show details',
                                      style: TextStyle(color: kMikadoYellow),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.keyboard_double_arrow_right_rounded,
                                      size: 18,
                                      color: kMikadoYellow,
                                    )
                                  ],
                                )
                              : null,
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
                          style: kSubtitle,
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
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemCount: tvShow.seasons.length,
    );
  }

  void _onPressedWatchlistButton(BuildContext context) {
    if (isWatchlist) {
      context.read<TvShowWatchlistBloc>().add(RemoveTvShowWatchList(tvShow));
    } else {
      context.read<TvShowWatchlistBloc>().add(InsertTvShowWatchlist(tvShow));
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
