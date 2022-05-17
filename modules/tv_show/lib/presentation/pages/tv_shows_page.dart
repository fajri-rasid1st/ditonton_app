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
      context.read<TvShowlistBloc>().add(FetchTvShowlist());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (context.watch<TvShowlistBloc>().state is TvShowlistError) {
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

              context.read<TvShowlistBloc>().add(FetchTvShowlist());

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
      child: BlocBuilder<TvShowlistBloc, TvShowlistState>(
        builder: ((context, state) {
          final hasData = state is TvShowlistHasData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SubHeading(
                title: 'On The Air',
                onTap: () => Navigator.pushNamed(context, onTheAirTvShowsRoute),
              ),
              if (hasData) ...[
                ItemList(
                  tvShows: state.onTheAirTvShows,
                  height: 180,
                  separatorWidth: 12,
                ),
              ] else ...[
                const SizedBox(
                  height: 180,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
              SubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularTvShowsRoute),
              ),
              if (hasData) ...[
                ItemList(
                  tvShows: state.popularTvShows,
                  height: 180,
                  separatorWidth: 12,
                ),
              ] else ...[
                const SizedBox(
                  height: 180,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
              SubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedTvShowsRoute),
              ),
              if (hasData) ...[
                ItemList(
                  tvShows: state.topRatedTvShows,
                  height: 180,
                  separatorWidth: 12,
                ),
              ] else ...[
                const SizedBox(
                  height: 180,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ],
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
