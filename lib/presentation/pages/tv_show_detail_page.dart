import 'package:ditonton/presentation/widgets/tv_show_detail_content.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/common/state_enum.dart';

class TvShowDetailPage extends StatefulWidget {
  static const routeName = '/tv-show-detail';

  final int id;

  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<TvShowDetailNotifier>(context, listen: false)
        ..fetchTvShowDetail(widget.id)
        ..loadTvShowWatchlistStatus(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvShowState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.tvShowState == RequestState.loaded) {
            return SafeArea(
              child: TvShowDetailContent(
                tvShow: provider.tvShow,
                tvShowRecommendations: provider.tvShowRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlist,
              ),
            );
          }

          return Center(
            key: const Key('error_message'),
            child: Text(provider.message),
          );
        },
      ),
    );
  }
}
