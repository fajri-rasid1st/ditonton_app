import 'package:ditonton/presentation/provider/movie_notifiers/movie_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/common/state_enum.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final int id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<MovieDetailNotifier>(context, listen: false)
        ..fetchMovieDetail(widget.id)
        ..loadMovieWatchlistStatus(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.movieState == RequestState.loaded) {
            final movie = provider.movie;

            return SafeArea(
              child: MovieDetailContent(
                movie: movie,
                recommendations: provider.movieRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlist,
              ),
            );
          }

          return Text(provider.message);
        },
      ),
    );
  }
}
