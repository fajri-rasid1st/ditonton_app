import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
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
          Consumer<MovieSearchNotifier>(
            builder: (context, provider, child) {
              if (provider.state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.state == RequestState.loaded) {
                return Expanded(
                  child: ListCardItem(movies: provider.searchResult),
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
