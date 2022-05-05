import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_shows_page.dart';
import 'package:flutter/material.dart';

class WatchlistScreen extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  final List<Widget> _pages = const <Widget>[
    WatchlistMoviesPage(),
    WatchlistTvShowsPage(),
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _buildScaffoldBody());

  SafeArea _buildScaffoldBody() {
    return SafeArea(
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  title: const Text('Watchlist'),
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: kMikadoYellow,
                    labelColor: kMikadoYellow,
                    unselectedLabelColor: kDavysGrey,
                    tabs: <Widget>[
                      Tab(child: Text('Movie', style: kDefaultText)),
                      Tab(child: Text('Tv Show', style: kDefaultText)),
                    ],
                  ),
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
            )
          ];
        }),
        body: TabBarView(
          controller: _tabController,
          children: _pages,
        ),
      ),
    );
  }
}
