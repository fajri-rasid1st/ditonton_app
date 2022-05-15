import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SubHeading(
            title: 'Now Playing',
            onTap: null,
          ),
          BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: ((context, state) {
              if (state is NowPlayingMoviesHasData) {
                return ItemList(
                  movies: state.movies,
                  height: 180,
                  separatorWidth: 12,
                );
              } else if (state is NowPlayingMoviesError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
          SubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(context, popularMoviesRoute),
          ),
          BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: ((context, state) {
              if (state is PopularMoviesHasData) {
                return ItemList(
                  movies: state.movies,
                  height: 180,
                  separatorWidth: 12,
                );
              } else if (state is PopularMoviesError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
          SubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, topRatedMoviesRoute),
          ),
          BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: ((context, state) {
              if (state is TopRatedMoviesHasData) {
                return ItemList(
                  movies: state.movies,
                  height: 180,
                  separatorWidth: 12,
                );
              } else if (state is TopRatedMoviesError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}