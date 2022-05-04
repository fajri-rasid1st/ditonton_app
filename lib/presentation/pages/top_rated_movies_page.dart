import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<TopRatedMoviesNotifier>(context, listen: false)
          .fetchTopRatedMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Movies')),
      body: Consumer<TopRatedMoviesNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == RequestState.loaded) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                return CardItem(movie: provider.movies[index]);
              },
              itemCount: provider.movies.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
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
