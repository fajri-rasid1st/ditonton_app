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

    final onTheAirError =
        context.watch<OnTheAirTvShowsBloc>().state is OnTheAirTvShowsError;
    final popularError =
        context.watch<PopularTvShowsBloc>().state is PopularTvShowsError;
    final topRatedError =
        context.watch<TopRatedTvShowsBloc>().state is TopRatedTvShowsError;

    if (onTheAirError || popularError || topRatedError) {
      return _buildErrorPage(context);
    }

    return _buildMainPage(context);
  }

  CustomInformation _buildErrorPage(BuildContext context) {
    return CustomInformation(
      key: const Key('error_message'),
      asset: 'assets/404-error-lost-in-space-pana.svg',
      title: 'Ops, Looks Like You\'re Offline',
      subtitle: 'Please check your internet connection.',
      child: BlocBuilder<PageReloadCubit, PageReloadState>(
        builder: ((context, state) {
          if (state.isPageReload) {
            return ElevatedButton.icon(
              onPressed: null,
              icon: const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: kDavysGrey,
                ),
              ),
              label: Text('Please Wait...', style: kDefaultText),
            );
          }

          return ElevatedButton.icon(
            onPressed: () async {
              context.read<PageReloadCubit>().reload();

              await Future.delayed(const Duration(seconds: 1));

              context.read<OnTheAirTvShowsBloc>().add(FetchOnTheAirTvShows());
              context.read<PopularTvShowsBloc>().add(FetchPopularTvShows());
              context.read<TopRatedTvShowsBloc>().add(FetchTopRatedTvShows());

              context.read<PageReloadCubit>().finish();
            },
            icon: const Icon(Icons.refresh),
            label: Text('Fetch Again', style: kDefaultText),
          );
        }),
      ),
    );
  }

  SingleChildScrollView _buildMainPage(BuildContext context) {
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
              }

              return const SizedBox(
                height: 180,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
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
              }

              return const SizedBox(
                height: 180,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
          ),
          SubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, topRatedTvShowsRoute),
          ),
          BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
            builder: ((context, state) {
              if (state is TopRatedTvShowsHasData) {
                return ItemList(
                  tvShows: state.tvShows,
                  height: 180,
                  separatorWidth: 12,
                );
              }

              return const SizedBox(
                height: 180,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
