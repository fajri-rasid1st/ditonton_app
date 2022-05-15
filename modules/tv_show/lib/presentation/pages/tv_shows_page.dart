// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

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

    Future.microtask(() {
      context.read<OnTheAirTvShowsBloc>().add(FetchOnTheAirTvShows());
      context.read<PopularTvShowsBloc>().add(FetchPopularTvShows());
      context.read<TopRatedTvShowsBloc>().add(FetchTopRatedTvShows());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SubHeading(
            title: 'On The Air',
            onTap: () => Navigator.pushNamed(context, onTheAirTvShowsRoute),
          ),
          BlocBuilder<OnTheAirTvShowsBloc, OnTheAirTvShowsState>(
            builder: ((context, state) {
              if (state is OnTheAirTvShowsHasData) {
                return ItemList(
                  tvShows: state.tvShows,
                  height: 180,
                  separatorWidth: 12,
                );
              } else if (state is OnTheAirTvShowsError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
          SubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(context, popularTvShowsRoute),
          ),
          BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
            builder: ((context, state) {
              if (state is PopularTvShowsHasData) {
                return ItemList(
                  tvShows: state.tvShows,
                  height: 180,
                  separatorWidth: 12,
                );
              } else if (state is PopularTvShowsError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
          SubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, topRatedTvShowsroute),
          ),
          BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
            builder: ((context, state) {
              if (state is TopRatedTvShowsHasData) {
                return ItemList(
                  tvShows: state.tvShows,
                  height: 180,
                  separatorWidth: 12,
                );
              } else if (state is TopRatedTvShowsError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
