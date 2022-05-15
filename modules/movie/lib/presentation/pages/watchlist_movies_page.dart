import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies_bloc/watchlist_movies_bloc.dart';

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

    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(FetchWatchlistMovies());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(FetchWatchlistMovies());
  }

  @override
  void dispose() {
    super.dispose();

    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
      builder: ((context, state) {
        if (state is WatchlistMoviesHasData) {
          return SliverListCardItem(movies: state.movies);
        } else if (state is WatchlistMoviesError) {
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
