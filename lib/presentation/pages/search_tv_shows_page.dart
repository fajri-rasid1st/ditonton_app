import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_show_search_bloc/tv_show_search_bloc.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              onChanged: (query) => context
                  .read<TvShowSearchBloc>()
                  .add(OnTvShowQueryChanged(query)),
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
              style: kHeading6,
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<TvShowSearchBloc, TvShowSearchState>(
            builder: (context, state) {
              if (state is TvShowSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvShowSearchHasData) {
                return Expanded(
                  child: ListCardItem(tvShows: state.tvShows),
                );
              } else if (state is TvShowSearchError) {
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
