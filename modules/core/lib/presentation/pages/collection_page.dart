import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.pushNamed(context, watchlistRoute),
            leading: const Icon(Icons.save_alt_rounded),
            title: const Text('Watchlist'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, aboutRoute),
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
