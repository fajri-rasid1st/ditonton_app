import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/popular_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvShowsPage extends StatefulWidget {
  static const routeName = '/popular-tv-show';

  const PopularTvShowsPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<PopularTvShowsNotifier>(context, listen: false)
          .fetchPopularTvShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Tv Shows')),
      body: Consumer<PopularTvShowsNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == RequestState.loaded) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                return CardItem(tvShow: provider.tvShows[index]);
              },
              itemCount: provider.tvShows.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            );
          }

          return Center(
            key: const Key('error_message'),
            child: Text(provider.message),
          );
        },
      ),
    );
  }
}
