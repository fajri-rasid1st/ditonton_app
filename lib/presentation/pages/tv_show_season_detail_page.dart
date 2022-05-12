import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_episodes_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class TvShowSeasonDetailPage extends StatefulWidget {
  static const routeName = '/tv-show-season-detail';

  final int tvShowId;
  final Season season;

  const TvShowSeasonDetailPage({
    Key? key,
    required this.tvShowId,
    required this.season,
  }) : super(key: key);

  @override
  State<TvShowSeasonDetailPage> createState() => _TvShowSeasonDetailPageState();
}

class _TvShowSeasonDetailPageState extends State<TvShowSeasonDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<TvShowEpisodesNotifier>(context, listen: false)
          .fetchTvShowEpisode(widget.tvShowId, widget.season.seasonNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowEpisodesNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == RequestState.loaded) {
            return _buildMainScreen(provider.episodes);
          }

          return Center(
            key: const Key('error_message'),
            child: Text(provider.message),
          );
        },
      ),
    );
  }

  NestedScrollView _buildMainScreen(List<Episode> episodes) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            forceElevated: isScrolled,
            pinned: true,
            expandedHeight: 260,
            title: Text(widget.season.name),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  CustomNetworkImage(
                    imgUrl: '$baseImageUrlW500${widget.season.posterPath}',
                    width: double.infinity,
                    placeHolderSize: 100,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [kRichBlack, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            kRichBlack.withOpacity(0.5),
                            Colors.transparent
                          ],
                        ),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 260 - kToolbarHeight,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'S${widget.season.seasonNumber} ● ${widget.season.episodeCount} Episodes',
                            style: kHeading5,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _showEpisodeAirDate(widget.season.airDate),
                            style: kSubtitle.copyWith(color: kMikadoYellow),
                          ),
                          const SizedBox(height: 4),
                          ReadMoreText(
                            widget.season.overview,
                            trimLines: 4,
                            trimMode: TrimMode.Line,
                            delimiter: ' ',
                            trimCollapsedText: '...Show more',
                            trimExpandedText: 'Show less',
                            style: const TextStyle(color: kDavysGrey),
                            lessStyle: const TextStyle(color: Colors.white),
                            moreStyle: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: _buildEpisodeList(episodes),
    );
  }

  ListView _buildEpisodeList(List<Episode> episodes) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: ((context, index) {
        final episode = episodes[index];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    CustomNetworkImage(
                      imgUrl: '$baseImageUrlW500${episode.stillPath}',
                      width: double.infinity,
                      height: 140,
                      placeHolderSize: 40,
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
                        'Episode ${episode.episodeNumber}',
                        style: kHeading6,
                      ),
                      subtitle: Text(
                        _showEpisodeAirDate(episode.airDate),
                        style: const TextStyle(color: kMikadoYellow),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    episode.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitle,
                  ),
                  ReadMoreText(
                    episode.overview,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Show more',
                    trimExpandedText: 'Show less',
                    style: const TextStyle(color: kDavysGrey),
                    lessStyle: const TextStyle(color: Colors.white),
                    moreStyle: const TextStyle(color: Colors.white),
                    delimiter: ' ',
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(),
        );
      },
      itemCount: episodes.length,
    );
  }

  String _showEpisodeAirDate(String airDate) {
    final airDateParse = airDate.isEmpty
        ? '?'
        : DateFormat('MMM dd, y').format(DateTime.parse(airDate));

    return airDateParse;
  }
}

class TvShowSeasonDetailArgs {
  final int tvShowId;
  final Season season;

  TvShowSeasonDetailArgs(this.tvShowId, this.season);
}
