// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Movies')),
      body: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
        builder: ((context, state) {
          if (state is TopRatedMoviesHasData) {
            return ListCardItem(movies: state.movies);
          } else if (state is TopRatedMoviesError) {
            return const CustomInformation(
              key: Key('error_message'),
              asset: 'assets/404-error-lost-in-space-pana.svg',
              title: 'Ops, Looks Like You\'re Offline',
              subtitle: 'Please check your internet connection.',
            );
          }

          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
