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
          return _buildSliverWatchlist(provider);
        }

        return Center(
          key: const Key('error_message'),
          child: Text(provider.message),
        );
      },
    );
  }

  Builder _buildSliverWatchlist(WatchlistTvShowsNotifier provider) {
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
                    final count = provider.watchlistTvShows.length;
                    final hasSeparator = index != count - 1;
                    final bottom = hasSeparator ? 8.0 : 0.0;

                    return Padding(
                      padding: EdgeInsets.only(bottom: bottom),
                      child: CardItem(tvShow: provider.watchlistTvShows[index]),
                    );
                  },
                  childCount: provider.watchlistTvShows.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
