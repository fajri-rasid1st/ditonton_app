import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/cubit/bottom_nav_cubit.dart';
import 'package:ditonton/presentation/pages/collection_page.dart';
import 'package:ditonton/presentation/pages/movies_page.dart';
import 'package:ditonton/presentation/pages/search_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: ((context, state) {
        return Scaffold(
          appBar: _buildAppBar(state, context),
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNavBar(state),
        );
      }),
    );
  }

  AppBar _buildAppBar(BottomNavState state, BuildContext context) {
    final routeName = state.index == 0
        ? SearchMoviesPage.routeName
        : SearchTvShowsPage.routeName;

    return AppBar(
      title: Text(state.title),
      actions: <Widget>[
        if (state.index != 2) ...[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, routeName),
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

  SafeArea _buildBody(BottomNavState state) {
    return SafeArea(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          switch (index) {
            case 0:
              context
                  .read<BottomNavCubit>()
                  .getBottomNavItem(BottomNavItem.movie);
              break;
            case 1:
              context
                  .read<BottomNavCubit>()
                  .getBottomNavItem(BottomNavItem.tvShow);
              break;
            case 2:
              context
                  .read<BottomNavCubit>()
                  .getBottomNavItem(BottomNavItem.collection);
              break;
          }
        },
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar(BottomNavState state) {
    return BottomNavigationBar(
      currentIndex: state.index,
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
