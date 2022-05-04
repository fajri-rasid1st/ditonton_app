import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  static const routeName = '/top-rated-tv-show';

  const TopRatedTvShowsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<TopRatedTvShowsNotifier>(context, listen: false)
          .fetchTopRatedTvShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Tv Shows')),
      body: Consumer<TopRatedTvShowsNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (data.state == RequestState.loaded) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                final tvShow = data.tvShows[index];

                return CardItem(tvShow: tvShow);
              },
              itemCount: data.tvShows.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            );
          }

          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        },
      ),
    );
  }
}
