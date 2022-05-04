import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    Future.microtask(
      () => Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Now Playing',
              style: kHeading6,
            ),
          ),
          Consumer<MovieListNotifier>(
            builder: (context, provider, child) {
              final state = provider.nowPlayingMovieState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(movies: provider.nowPlayingMovies);
              }

              return const SizedBox(
                height: 100,
                child: Center(
                  child: Text('Failed to fetch now playing movies'),
                ),
              );
            },
          ),
          _buildSubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(
              context,
              PopularMoviesPage.routeName,
            ),
          ),
          Consumer<MovieListNotifier>(
            builder: (context, provider, child) {
              final state = provider.popularMoviesState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(movies: provider.popularMovies);
              }

              return const SizedBox(
                height: 100,
                child: Center(
                  child: Text('Failed to fetch popular movies'),
                ),
              );
            },
          ),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(
              context,
              TopRatedMoviesPage.routeName,
            ),
          ),
          Consumer<MovieListNotifier>(
            builder: (context, proivider, child) {
              final state = proivider.topRatedMoviesState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(movies: proivider.topRatedMovies);
              }

              return const SizedBox(
                height: 100,
                child: Center(
                  child: Text('Failed to fetch top rated movies'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _buildSubHeading({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: kHeading6,
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              children: const <Widget>[
                Text('See more'),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
