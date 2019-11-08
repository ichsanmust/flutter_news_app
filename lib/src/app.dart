import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/news_bloc.dart';
// import 'package:news_app/src/ui/home_page.dart';
import 'package:news_app/src/ui/splash_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => NewsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News Application',
        theme: ThemeData.dark().copyWith(
          canvasColor: Colors.transparent,
          primaryColor: Colors.black,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
