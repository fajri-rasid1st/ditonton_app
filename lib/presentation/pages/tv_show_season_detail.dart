import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_episodes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowSeasonDetail extends StatefulWidget {
  static const routeName = '/tv-show-season-detail';

  final int tvShowId;
  final Season season;

  const TvShowSeasonDetail({
    Key? key,
    required this.tvShowId,
    required this.season,
  }) : super(key: key);

  @override
  State<TvShowSeasonDetail> createState() => _TvShowSeasonDetailState();
}

class _TvShowSeasonDetailState extends State<TvShowSeasonDetail> {
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
            return _buildScreen(provider.episodes);
          }

          return Center(
            key: const Key('error_message'),
            child: Text(provider.message),
          );
        },
      ),
    );
  }

  Scaffold _buildScreen(List<Episode> episodes) {
    return const Scaffold();
  }
}

class TvShowSeasonDetailArgs {
  final int tvShowId;
  final Season season;

  TvShowSeasonDetailArgs(this.tvShowId, this.season);
}
