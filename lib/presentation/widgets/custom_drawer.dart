import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
