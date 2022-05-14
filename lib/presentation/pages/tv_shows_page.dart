import 'package:ditonton/presentation/bloc/on_the_air_tv_shows_bloc/on_the_air_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/widgets/item_list.dart';
import 'package:ditonton/presentation/widgets/subheading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            onTap: () => Navigator.pushNamed(
              context,
              OnTheAirTvShowsPage.routeName,
            ),
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
            onTap: () => Navigator.pushNamed(
              context,
              PopularTvShowsPage.routeName,
            ),
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
            onTap: () => Navigator.pushNamed(
              context,
              TopRatedTvShowsPage.routeName,
            ),
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
