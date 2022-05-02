import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_demo/constants/colors.dart';
import 'package:movie_demo/constants/route_constants.dart';
import 'package:movie_demo/pages/search_movie_home.dart';
import 'package:movie_demo/provider/omdb_model_provider.dart';
import 'package:movie_demo/routes/router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<OmdbModelProvider>(
        create: (_) => OmdbModelProvider()),
  ];

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: KColors.scaffoldBgColor,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: KColors.bgColorOffet,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: const MovieSearchHome(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: homeRoute,
    );
  }
}
