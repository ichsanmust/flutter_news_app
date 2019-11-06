import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter News Application',
      // theme: ThemeData(
      //   primarySwatch: Colors.deepPurple,
      // ),
      theme: ThemeData.dark().copyWith(
        canvasColor: Colors.transparent,
        primaryColor: Colors.black,
        // textTheme: Theme.of(context).textTheme.apply(
        //       bodyColor: Colors.pink,
        //       displayColor: Colors.pink,
        //     ),
      ),

      // darkTheme: ThemeData.dark(),
      home: HomePage(title: 'Flutter News Application'),
    );
  }
}