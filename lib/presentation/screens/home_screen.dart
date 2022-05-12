import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/collection_page.dart';
import 'package:ditonton/presentation/pages/movies_page.dart';
import 'package:ditonton/presentation/pages/search_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_movies_page.dart';
import 'package:ditonton/presentation/provider/bottom_nav_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = const <Widget>[
    MoviesPage(),
    TvShowsPage(),
    CollectionPage(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavNotifier>(
      builder: ((context, provider, child) {
        return Scaffold(
          appBar: _buildAppBar(provider, context),
          body: _buildBody(provider),
          bottomNavigationBar: _buildBottomNavBar(provider),
        );
      }),
    );
  }

  AppBar _buildAppBar(BottomNavNotifier provider, BuildContext context) {
    return AppBar(
      title: Text(provider.title),
      actions: <Widget>[
        if (provider.index != 2) ...[
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              provider.index == 0
                  ? SearchMoviesPage.routeName
                  : SearchTvShowsPage.routeName,
            ),
            icon: const Icon(Icons.search_rounded),
          )
        ],
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: kRichBlack,
            child: Image.asset(
              'assets/circle-g.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  SafeArea _buildBody(BottomNavNotifier provider) {
    return SafeArea(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          provider.index = index;

          switch (index) {
            case 0:
              provider.title = 'Movies';
              break;
            case 1:
              provider.title = 'Tv Shows';
              break;
            case 2:
              provider.title = 'Collections';
              break;
          }
        },
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar(BottomNavNotifier provider) {
    return BottomNavigationBar(
      currentIndex: provider.index,
      backgroundColor: kRichBlack,
      selectedFontSize: 10,
      selectedItemColor: kMikadoYellow,
      unselectedFontSize: 10,
      unselectedItemColor: kDavysGrey,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_outlined),
          activeIcon: Icon(Icons.movie),
          label: 'Movie',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_display_outlined),
          activeIcon: Icon(Icons.smart_display),
          label: 'Tv Show',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmarks_outlined),
          activeIcon: Icon(Icons.bookmarks),
          label: 'Collection',
        ),
      ],
      onTap: (index) => _pageController.jumpToPage(index),
    );
  }
}
