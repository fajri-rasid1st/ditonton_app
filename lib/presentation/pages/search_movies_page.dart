import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMoviesPage extends StatelessWidget {
  static const routeName = '/search-movie';

  const SearchMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Movie')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (query) => context
                  .read<MovieSearchBloc>()
                  .add(OnMovieQueryChanged(query)),
              decoration: const InputDecoration(
                hintText: 'Search movie...',
                prefixIcon: Icon(Icons.search_rounded),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Search result',
              style: kHeading6,
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<MovieSearchBloc, MovieSearchState>(
            builder: (context, state) {
              if (state is MovieSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieSearchHasData) {
                return Expanded(
                  child: ListCardItem(movies: state.movies),
                );
              } else if (state is MovieSearchError) {
                return Expanded(
                  child: Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  ),
                );
              }

              return Expanded(child: Container());
            },
          ),
        ],
      ),
    );
  }
}
