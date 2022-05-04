import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/custom_drawer.dart';
import 'package:ditonton/presentation/widgets/item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  static const routeName = '/home-movie';

  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
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
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: <IconButton>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
            icon: const Icon(Icons.search_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingMovieState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(movies: data.nowPlayingMovies);
              }

              return const Text('Failed');
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () {
                Navigator.pushNamed(context, PopularMoviesPage.routeName);
              },
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.popularMoviesState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(movies: data.popularMovies);
              }

              return const Text('Failed');
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () {
                Navigator.pushNamed(context, TopRatedMoviesPage.routeName);
              },
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.topRatedMoviesState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(movies: data.topRatedMovies);
              }

              return const Text('Failed');
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const <Widget>[
                Text('See more'),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
