import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movies_page.dart';
import 'package:ditonton/presentation/pages/tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/bottom_nav_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = <Widget>[
    const MoviesPage(),
    const TvShowsPage(),
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
      builder: ((context, notifier, child) {
        return Scaffold(
          drawer: _buildDrawer(context),
          appBar: _buildAppBar(notifier, context),
          body: _buildBody(notifier),
          bottomNavigationBar: _buildBottomNavBar(notifier),
        );
      }),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text(
              'Ditonton',
              style: kDefaultText,
            ),
            accountEmail: Text(
              'ditonton@dicoding.com',
              style: kDefaultText,
            ),
          ),
          ListTile(
            onTap: () => Navigator.pop(context),
            leading: const Icon(Icons.explore_outlined),
            title: Text(
              'Discover',
              style: kDefaultText,
            ),
          ),
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName),
            leading: const Icon(Icons.save_alt_rounded),
            title: Text(
              'Watchlist',
              style: kDefaultText,
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AboutPage.routeName),
            leading: const Icon(Icons.info_outline_rounded),
            title: Text(
              'About',
              style: kDefaultText,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BottomNavNotifier notifier, BuildContext context) {
    return AppBar(
      title: Text(notifier.title),
      actions: <IconButton>[
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchMoviesPage.routeName);
          },
          icon: const Icon(Icons.search_rounded),
        )
      ],
    );
  }

  Widget _buildBody(BottomNavNotifier notifier) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: _pages,
      onPageChanged: (index) {
        notifier.index = index;

        switch (index) {
          case 0:
            notifier.title = 'Ditonton Movies';
            break;
          case 1:
            notifier.title = 'Ditonton Tv Shows';
            break;
        }
      },
    );
  }

  BottomNavigationBar _buildBottomNavBar(BottomNavNotifier notifier) {
    return BottomNavigationBar(
      currentIndex: notifier.index,
      backgroundColor: kRichBlack,
      selectedFontSize: 12,
      selectedItemColor: kMikadoYellow,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedFontSize: 12,
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
      ],
      onTap: (index) => _pageController.jumpToPage(index),
    );
  }
}
