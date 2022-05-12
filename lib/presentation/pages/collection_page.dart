import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.pushNamed(
              context,
              WatchlistScreen.routeName,
            ),
            leading: const Icon(Icons.save_alt_rounded),
            title: const Text('Watchlist'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(
              context,
              AboutPage.routeName,
            ),
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
