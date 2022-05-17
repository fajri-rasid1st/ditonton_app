// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';

class SearchMoviesPage extends StatelessWidget {
  const SearchMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Movie')),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
          BlocBuilder<MovieSearchBloc, MovieSearchState>(
            builder: (context, state) {
              if (state is MovieSearchLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is MovieSearchHasData) {
                return Expanded(
                  child: state.movies.isEmpty
                      ? const CustomInformation(
                          asset: 'assets/eating-disorder-pana.svg',
                          title: 'Movies Not Found',
                          subtitle: 'Try entering another keywords.',
                        )
                      : ListCardItem(movies: state.movies),
                );
              } else if (state is MovieSearchError) {
                return Expanded(
                  key: const Key('error_message'),
                  child: state.message.isEmpty
                      ? const CustomInformation(
                          asset: 'assets/3d-glasses-pana.svg',
                          title: 'What Movie Are You Looking For?',
                          subtitle: 'Search results will appear here.',
                        )
                      : const CustomInformation(
                          asset: 'assets/404-error-lost-in-space-pana.svg',
                          title: 'Ops, Looks Like You\'re Offline',
                          subtitle: 'Please check your internet connection.',
                        ),
                );
              }

              return const Expanded(
                child: CustomInformation(
                  asset: 'assets/3d-glasses-pana.svg',
                  title: 'What Movie Are You Looking For?',
                  subtitle: 'Search results will appear here.',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
