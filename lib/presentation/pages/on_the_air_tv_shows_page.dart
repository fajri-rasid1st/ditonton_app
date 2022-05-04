import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/on_the_air_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirTvShowsPage extends StatefulWidget {
  static const routeName = '/on-the-air-tv-show';

  const OnTheAirTvShowsPage({Key? key}) : super(key: key);

  @override
  _OnTheAirTvShowsPageState createState() => _OnTheAirTvShowsPageState();
}

class _OnTheAirTvShowsPageState extends State<OnTheAirTvShowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<OnTheAirTvShowsNotifier>(context, listen: false)
          .fetchOnTheAirTvShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('On The Air Tv Shows')),
      body: Consumer<OnTheAirTvShowsNotifier>(
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
