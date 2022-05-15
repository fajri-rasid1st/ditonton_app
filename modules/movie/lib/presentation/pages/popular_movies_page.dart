import 'package:core/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies')),
      body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: ((context, state) {
          if (state is PopularMoviesHasData) {
            return ListCardItem(movies: state.movies);
          } else if (state is PopularMoviesError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          }

          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
