import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/watchlist_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvShowsPage extends StatefulWidget {
  const WatchlistTvShowsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvShowsPageState createState() => _WatchlistTvShowsPageState();
}

class _WatchlistTvShowsPageState extends State<WatchlistTvShowsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<WatchlistTvShowsNotifier>(context, listen: false)
          .fetchWatchlistTvShows(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvShowsNotifier>(context, listen: false)
        .fetchWatchlistTvShows();
  }

  @override
  void dispose() {
    super.dispose();

    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistTvShowsNotifier>(
      builder: (context, provider, child) {
        if (provider.watchlistState == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.watchlistState == RequestState.loaded) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) {
              return CardItem(tvShow: provider.watchlistTvShows[index]);
            },
            itemCount: provider.watchlistTvShows.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          );
        }

        return Center(
          key: const Key('error_message'),
          child: Text(provider.message),
        );
      },
    );
  }
}
