import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/watchlist_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<WatchlistMoviesNotifier>(context, listen: false)
          .fetchWatchlistMovies(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMoviesNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  void dispose() {
    super.dispose();

    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistMoviesNotifier>(
      builder: (context, provider, child) {
        if (provider.watchlistState == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.watchlistState == RequestState.loaded) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) {
              return CardItem(movie: provider.watchlistMovies[index]);
            },
            itemCount: provider.watchlistMovies.length,
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
