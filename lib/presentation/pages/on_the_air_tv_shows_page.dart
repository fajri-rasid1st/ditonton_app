import 'package:ditonton/presentation/bloc/on_the_air_tv_shows_bloc/on_the_air_tv_shows_bloc.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          }

          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
