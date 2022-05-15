import 'package:core/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

class PopularTvShowsPage extends StatefulWidget {
  const PopularTvShowsPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PopularTvShowsBloc>().add(FetchPopularTvShows());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Tv Shows')),
      body: BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
        builder: ((context, state) {
          if (state is PopularTvShowsHasData) {
            return ListCardItem(tvShows: state.tvShows);
          } else if (state is PopularTvShowsError) {
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
