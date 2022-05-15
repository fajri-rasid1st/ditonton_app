import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tv_show/tvshow.dart';

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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

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
            case popularMoviesRoute:
              return MaterialPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case topRatedMoviesRoute:
              return MaterialPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case onTheAirTvShowsRoute:
              return MaterialPageRoute(
                builder: (_) => const OnTheAirTvShowsPage(),
              );
            case popularTvShowsRoute:
              return MaterialPageRoute(
                builder: (_) => const PopularTvShowsPage(),
              );
            case topRatedTvShowsroute:
              return MaterialPageRoute(
                builder: (_) => const TopRatedTvShowsPage(),
              );
            case movieDetailRoute:
              final id = settings.arguments as int;

              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case tvShowDetailRoute:
              final id = settings.arguments as int;

              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case searchMoviesRoute:
              return MaterialPageRoute(
                builder: (_) => const SearchMoviesPage(),
              );
            case searchTvShowsRoute:
              return MaterialPageRoute(
                builder: (_) => const SearchTvShowsPage(),
              );
            case tvShowSeasonDetailRoute:
              final arguments = settings.arguments as TvShowSeasonDetailArgs;

              return MaterialPageRoute(
                builder: (_) => TvShowSeasonDetailPage(
                  tvShowId: arguments.tvShowId,
                  season: arguments.season,
                ),
              );
            case aboutRoute:
              return MaterialPageRoute(
                builder: (_) => const AboutPage(),
              );
            case watchlistRoute:
              return MaterialPageRoute(
                builder: (_) => const WatchlistScreen(),
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
