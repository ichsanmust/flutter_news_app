import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/news_bloc.dart';
import 'package:news_app/src/ui/home_page.dart';
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
      ),
      // child: Consumer<Counter>(
      //   builder: (context, counter, _) {
      //     return MaterialApp(
      //       title: 'Flutter Demo',
      //       theme: ThemeData(
      //         primarySwatch: Colors.blue,
      //       ),
      //       home: MyHomePage(title: 'Flutter Demo Home Page'),
      //     );
      //   },
      // ),
    );
  }
}
