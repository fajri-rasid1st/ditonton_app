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
      context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final nowPlayingError =
        context.watch<NowPlayingMoviesBloc>().state is NowPlayingMoviesError;
    final popularError =
        context.watch<PopularMoviesBloc>().state is PopularMoviesError;
    final topRatedError =
        context.watch<TopRatedMoviesBloc>().state is TopRatedMoviesError;

    if (nowPlayingError || popularError || topRatedError) {
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

              context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
              context.read<PopularMoviesBloc>().add(FetchPopularMovies());
              context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());

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
          const SubHeading(
            title: 'Now Playing',
            onTap: null,
          ),
          BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: ((context, state) {
              if (state is NowPlayingMoviesHasData) {
                return ItemList(
                  movies: state.movies,
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
            onTap: () => Navigator.pushNamed(context, popularMoviesRoute),
          ),
          BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: ((context, state) {
              if (state is PopularMoviesHasData) {
                return ItemList(
                  movies: state.movies,
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
            onTap: () => Navigator.pushNamed(context, topRatedMoviesRoute),
          ),
          BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: ((context, state) {
              if (state is TopRatedMoviesHasData) {
                return ItemList(
                  movies: state.movies,
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
