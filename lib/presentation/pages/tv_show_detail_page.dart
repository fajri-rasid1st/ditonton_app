import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_show_detail_bloc/tv_show_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc/tv_show_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_show_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailPage extends StatefulWidget {
  static const routeName = '/tv-show-detail';

  final int id;

  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TvShowDetailBloc>().add(FetchTvShowDetail(widget.id));
      context
          .read<TvShowWatchlistBloc>()
          .add(LoadTvShowWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isWatchlist = _getWatchlistStatus(context);

    return Scaffold(
      body: BlocListener<TvShowWatchlistBloc, TvShowWatchlistState>(
        listener: (context, state) {
          if (state is InsertOrRemoveTvShowWatchlistSuccess) {
            final SnackBar snackBar = SnackBar(
              content: Text(state.successMessage, style: kDefaultText),
              backgroundColor: kMikadoYellow,
              duration: const Duration(seconds: 3),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          } else if (state is InsertOrRemoveTvShowWatchlistFailed) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text(state.failureMessage));
              },
            );
          }
        },
        child: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
          builder: (context, state) {
            if (state is TvShowDetailHasData) {
              return TvShowDetailContent(
                tvShow: state.tvShowDetail,
                recommendations: state.recommendations,
                isWatchlist: _isWatchlist,
              );
            } else if (state is TvShowDetailError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  bool _getWatchlistStatus(BuildContext context) {
    final state = context.watch<TvShowWatchlistBloc>().state;

    if (state is TvShowWatchlistStatusHasData) return state.isWatchlist;

    return false;
  }
}
