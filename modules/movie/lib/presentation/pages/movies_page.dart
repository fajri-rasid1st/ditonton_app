// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MovielistBloc>().add(FetchMovielist());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (context.watch<MovielistBloc>().state is MovielistError) {
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

              context.read<MovielistBloc>().add(FetchMovielist());

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
      child: BlocBuilder<MovielistBloc, MovielistState>(
        builder: ((context, state) {
          final hasData = state is MovielistHasData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SubHeading(
                title: 'Now Playing',
                onTap: null,
              ),
              if (hasData) ...[
                ItemList(
                  movies: state.nowPlayingMovies,
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
                onTap: () => Navigator.pushNamed(context, popularMoviesRoute),
              ),
              if (hasData) ...[
                ItemList(
                  movies: state.popularMovies,
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
                onTap: () => Navigator.pushNamed(context, topRatedMoviesRoute),
              ),
              if (hasData) ...[
                ItemList(
                  movies: state.topRatedMovies,
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
