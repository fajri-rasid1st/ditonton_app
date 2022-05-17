// coverage:ignore-file

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

class TvShowDetailPage extends StatefulWidget {
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
              return CustomInformation(
                key: const Key('error_message'),
                asset: 'assets/404-error-lost-in-space-pana.svg',
                title: 'Ops, Looks Like You\'re Offline',
                subtitle: 'Please check your internet connection.',
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text('Go Back', style: kSubtitle),
                ),
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
