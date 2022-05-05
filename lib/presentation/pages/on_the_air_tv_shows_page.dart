import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/on_the_air_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
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
        builder: (context, provider, child) {
          if (provider.state == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == RequestState.loaded) {
            return ListCardItem(tvShows: provider.tvShows);
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
