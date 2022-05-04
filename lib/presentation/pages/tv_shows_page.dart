import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/widgets/item_list.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSubHeading(
            title: 'On The Air',
            onTap: () {
              Navigator.pushNamed(context, OnTheAirTvShowsPage.routeName);
            },
          ),
          Consumer<TvShowListNotifier>(builder: (context, data, child) {
            final state = data.onTheAirTvShowsState;

            if (state == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state == RequestState.loaded) {
              return ItemList(tvShows: data.onTheAirTvShows);
            }

            return const SizedBox(
              height: 100,
              child: Center(
                child: Text('Failed to fetch tv shows'),
              ),
            );
          }),
          _buildSubHeading(
            title: 'Popular',
            onTap: () {
              Navigator.pushNamed(context, PopularTvShowsPage.routeName);
            },
          ),
          Consumer<TvShowListNotifier>(builder: (context, data, child) {
            final state = data.popularTvShowsState;

            if (state == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state == RequestState.loaded) {
              return ItemList(tvShows: data.popularTvShows);
            }

            return const SizedBox(
              height: 100,
              child: Center(
                child: Text('Failed to fetch tv shows'),
              ),
            );
          }),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () {
              Navigator.pushNamed(context, TopRatedTvShowsPage.routeName);
            },
          ),
          Consumer<TvShowListNotifier>(builder: (context, data, child) {
            final state = data.topRatedTvShowsState;

            if (state == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state == RequestState.loaded) {
              return ItemList(tvShows: data.topRatedTvShows);
            }

            return const SizedBox(
              height: 100,
              child: Center(
                child: Text('Failed to fetch tv shows'),
              ),
            );
          }),
        ],
      ),
    );
  }

  Padding _buildSubHeading({required String title, required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: kHeading6,
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              children: const <Widget>[
                Text('See more'),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
