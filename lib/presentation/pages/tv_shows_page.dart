import 'package:ditonton/presentation/pages/on_the_air_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/widgets/item_list.dart';
import 'package:ditonton/presentation/widgets/subheading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowsPage extends StatefulWidget {
  const TvShowsPage({Key? key}) : super(key: key);

  @override
  _TvShowsPageState createState() => _TvShowsPageState();
}

class _TvShowsPageState extends State<TvShowsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<TvShowListNotifier>(context, listen: false)
        ..fetchOnTheAirTvShows()
        ..fetchPopularTvShows()
        ..fetchTopRatedTvShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SubHeading(
            title: 'On The Air',
            onTap: () => Navigator.pushNamed(
              context,
              OnTheAirTvShowsPage.routeName,
            ),
          ),
          Consumer<TvShowListNotifier>(
            builder: (context, provider, child) {
              final state = provider.onTheAirTvShowsState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(tvShows: provider.onTheAirTvShows);
              }

              return const SizedBox(
                height: 100,
                child: Center(
                  child: Text('Failed to fetch on the air tv shows'),
                ),
              );
            },
          ),
          SubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(
              context,
              PopularTvShowsPage.routeName,
            ),
          ),
          Consumer<TvShowListNotifier>(
            builder: (context, provider, child) {
              final state = provider.popularTvShowsState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(tvShows: provider.popularTvShows);
              }

              return const SizedBox(
                height: 100,
                child: Center(
                  child: Text('Failed to fetch popular tv shows'),
                ),
              );
            },
          ),
          SubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(
              context,
              TopRatedTvShowsPage.routeName,
            ),
          ),
          Consumer<TvShowListNotifier>(
            builder: (context, provider, child) {
              final state = provider.topRatedTvShowsState;

              if (state == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.loaded) {
                return ItemList(tvShows: provider.topRatedTvShows);
              }

              return const SizedBox(
                height: 100,
                child: Center(
                  child: Text('Failed to fetch top rated tv shows'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
