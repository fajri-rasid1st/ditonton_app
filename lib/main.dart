import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/bottom_nav_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/watchlist_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/on_the_air_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/popular_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Prevent landscape orientation
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Change status bar color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: kRichBlack,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnTheAirTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvShowsNotifier>(),
        ),
        ChangeNotifierProvider<BottomNavNotifier>(
          create: (_) => BottomNavNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const MainScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const PopularMoviesPage();
              });
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const TopRatedMoviesPage();
              });
            case OnTheAirTvShowsPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const OnTheAirTvShowsPage();
              });
            case PopularTvShowsPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const PopularTvShowsPage();
              });
            case TopRatedTvShowsPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const TopRatedTvShowsPage();
              });
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;

              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const SearchMoviesPage();
              });
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const WatchlistMoviesPage();
              });
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) {
                return const AboutPage();
              });
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
