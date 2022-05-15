import 'package:core/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  const TopRatedTvShowsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TopRatedTvShowsBloc>().add(FetchTopRatedTvShows());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Tv Shows')),
      body: BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
        builder: ((context, state) {
          if (state is TopRatedTvShowsHasData) {
            return ListCardItem(tvShows: state.tvShows);
          } else if (state is TopRatedTvShowsError) {
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
