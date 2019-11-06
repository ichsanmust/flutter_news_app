import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/io_client.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterExtra with ChangeNotifier {
  int _count = 20;
  int get count => _count;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void decrement() async{

    _isLoading = true;
    notifyListeners();

    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);

    String url = 'http://localhost/greatpertamina/site/test';
    var response = await ioClient.get(url, headers: {
      // 'authorization': 'bearer $token'
    });

    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse['status']);
    // print(response.statusCode);
    // var returnData = null;
    // if (response.statusCode == 201) {
      // var jsonResponse = convert.jsonDecode(response.body);
    // }

     _isLoading = false;
    // _count--;
    _count = jsonResponse['status'];
    notifyListeners();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Counter()),
        ChangeNotifierProvider(builder: (_) => CounterExtra()),
      ],
      child: Consumer<Counter>(
        builder: (context, counter, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    // final counextra = Provider.of<CounterExtra>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.count}',
              style: Theme.of(context).textTheme.display1,
            ),
            Consumer<CounterExtra>(
              builder: (context, counextra, _) {
                if (counextra.isLoading){
                  return new Center(
                    child: new Opacity(
                      opacity: 1.0,
                      child: new CircularProgressIndicator(),
                    ),
                  );
                }
                return Text(
                  '${counextra.count}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            FlatButton(
              child: Text('view'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ViewData()));
              },
            ),

            FlatButton(
              child: Text('decrement'),
              onPressed: () {
                Provider.of<CounterExtra>(context, listen: false).decrement();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // `listen: false` is specified here because otherwise that would make
          // `IncrementCounterButton` rebuild when the counter updates.
          Provider.of<Counter>(context, listen: false).increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ViewData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          '${counter.count}',
        ),
        FlatButton(
          child: Text('back'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ));
  }
}
