// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

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

    Future.microtask(() {
      context.read<WatchlistTvShowsBloc>().add(FetchWatchlistTvShows());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvShowsBloc>().add(FetchWatchlistTvShows());
  }

  @override
  void dispose() {
    super.dispose();

    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      builder: ((context, state) {
        if (state is WatchlistTvShowsHasData) {
          if (state.tvShows.isEmpty) {
            return const CustomInformation(
              asset: 'assets/videotape-pana.svg',
              title: 'Watchlist is Still Empty',
              subtitle: 'Your tv show watchlist will appear here.',
            );
          }

          return SliverListCardItem(tvShows: state.tvShows);
        } else if (state is WatchlistTvShowsError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
