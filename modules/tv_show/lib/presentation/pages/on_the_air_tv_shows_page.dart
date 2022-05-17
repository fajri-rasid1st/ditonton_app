// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

class OnTheAirTvShowsPage extends StatefulWidget {
  const OnTheAirTvShowsPage({Key? key}) : super(key: key);

  @override
  _OnTheAirTvShowsPageState createState() => _OnTheAirTvShowsPageState();
}

class _OnTheAirTvShowsPageState extends State<OnTheAirTvShowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OnTheAirTvShowsBloc>().add(FetchOnTheAirTvShows());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('On The Air Tv Shows')),
      body: BlocBuilder<OnTheAirTvShowsBloc, OnTheAirTvShowsState>(
        builder: ((context, state) {
          if (state is OnTheAirTvShowsHasData) {
            return ListCardItem(tvShows: state.tvShows);
          } else if (state is OnTheAirTvShowsError) {
            return const CustomInformation(
              key: Key('error_message'),
              asset: 'assets/404-error-lost-in-space-pana.svg',
              title: 'Ops, Looks Like You\'re Offline',
              subtitle: 'Please check your internet connection.',
            );
          }

          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
