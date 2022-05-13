import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_search_notifier.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTvShowsPage extends StatelessWidget {
  static const routeName = '/search-tv-show';

  const SearchTvShowsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Tv Show')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onSubmitted: (query) {
                Provider.of<TvShowSearchNotifier>(context, listen: false)
                    .fetchTvShowSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search tv show...',
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
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 8),
          Consumer<TvShowSearchNotifier>(
            builder: (context, provider, child) {
              if (provider.state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.state == RequestState.loaded) {
                return Expanded(
                  child: ListCardItem(tvShows: provider.searchResult),
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
