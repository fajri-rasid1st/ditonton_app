// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

class SearchTvShowsPage extends StatelessWidget {
  const SearchTvShowsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Tv Show')),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
          BlocBuilder<TvShowSearchBloc, TvShowSearchState>(
            builder: (context, state) {
              if (state is TvShowSearchLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TvShowSearchHasData) {
                return Expanded(
                  child: state.tvShows.isEmpty
                      ? const CustomInformation(
                          asset: 'assets/eating-disorder-pana.svg',
                          title: 'Tv Shows Not Found',
                          subtitle: 'Try entering another keywords.',
                        )
                      : ListCardItem(tvShows: state.tvShows),
                );
              } else if (state is TvShowSearchError) {
                return Expanded(
                  key: const Key('error_message'),
                  child: state.message.isEmpty
                      ? const CustomInformation(
                          asset: 'assets/3d-glasses-pana.svg',
                          title: 'What Tv Show Are You Looking For?',
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
                  title: 'What Tv Show Are You Looking For?',
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
