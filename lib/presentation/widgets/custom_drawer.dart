import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            onTap: () => Navigator.pop(context),
            leading: const Icon(Icons.explore_outlined),
            title: const Text('Discover'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.save_alt_rounded),
            title: const Text('Watchlist'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AboutPage.routeName),
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
