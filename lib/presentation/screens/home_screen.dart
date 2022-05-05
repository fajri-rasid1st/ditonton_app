import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movies_page.dart';
import 'package:ditonton/presentation/pages/search_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_movies_page.dart';
import 'package:ditonton/presentation/provider/bottom_nav_notifier.dart';
import 'package:ditonton/presentation/screens/watchlist_screen.dart';
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
          drawer: _buildDrawer(context),
          appBar: _buildAppBar(provider, context),
          body: _buildBody(provider),
          bottomNavigationBar: _buildBottomNavBar(provider),
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
            onTap: () => Navigator.pushNamed(
              context,
              WatchlistScreen.routeName,
            ),
            leading: const Icon(Icons.save_alt_rounded),
            title: Text(
              'Watchlist',
              style: kDefaultText,
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(
              context,
              AboutPage.routeName,
            ),
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

  AppBar _buildAppBar(BottomNavNotifier provider, BuildContext context) {
    return AppBar(
      title: Text(provider.title),
      actions: <IconButton>[
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
              provider.title = 'Ditonton Movies';
              break;
            case 1:
              provider.title = 'Ditonton Tv Shows';
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
