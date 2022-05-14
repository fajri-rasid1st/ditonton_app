import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/movie-detail';

  final int id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id));
      context
          .read<MovieWatchlistBloc>()
          .add(LoadMovieWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isWatchlist = _getWatchlistStatus(context);

    return Scaffold(
      body: BlocListener<MovieWatchlistBloc, MovieWatchlistState>(
        listener: (context, state) {
          if (state is InsertOrRemoveMovieWatchlistSuccess) {
            final SnackBar snackBar = SnackBar(
              content: Text(state.successMessage, style: kDefaultText),
              backgroundColor: kMikadoYellow,
              duration: const Duration(milliseconds: 2000),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          } else if (state is InsertOrRemoveMovieWatchlistFailed) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text(state.failureMessage));
              },
            );
          }
        },
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailHasData) {
              return MovieDetailContent(
                movie: state.movieDetail,
                recommendations: state.recommendations,
                isWatchlist: _isWatchlist,
              );
            } else if (state is MovieDetailError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  bool _getWatchlistStatus(BuildContext context) {
    final state = context.watch<MovieWatchlistBloc>().state;

    if (state is MovieWatchlistStatusHasData) return state.isWatchlist;

    return false;
  }
}
