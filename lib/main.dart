import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/http_ssl_pinning.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tv_shows_bloc/on_the_air_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_detail_bloc/tv_show_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_episodes_bloc/tv_show_episodes_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_search_bloc/tv_show_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc/tv_show_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_shows_bloc/watchlist_tv_shows_bloc.dart';
import 'package:ditonton/presentation/cubit/bottom_nav_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_movies_page.dart';
import 'package:ditonton/presentation/pages/search_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_show_season_detail_page.dart';
import 'package:ditonton/presentation/screens/home_screen.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
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

  // Initialize ssl pinning
  await HttpSslPinning.init();

  // Initialize firebase
  await Firebase.initializeApp();

  // Initialize injector
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvShowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvShowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvShowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowEpisodesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvShowsBloc>(),
        ),
        BlocProvider(create: (_) => BottomNavCubit()),
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
        home: const HomeScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case OnTheAirTvShowsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const OnTheAirTvShowsPage(),
              );
            case PopularTvShowsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const PopularTvShowsPage(),
              );
            case TopRatedTvShowsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const TopRatedTvShowsPage(),
              );
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;

              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvShowDetailPage.routeName:
              final id = settings.arguments as int;

              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SearchMoviesPage(),
              );
            case SearchTvShowsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SearchTvShowsPage(),
              );
            case TvShowSeasonDetailPage.routeName:
              final arguments = settings.arguments as TvShowSeasonDetailArgs;

              return MaterialPageRoute(
                builder: (_) => TvShowSeasonDetailPage(
                  tvShowId: arguments.tvShowId,
                  season: arguments.season,
                ),
              );
            case AboutPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const AboutPage(),
              );
            case WatchlistPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const WatchlistPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(child: Text('Page not found :(')),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
