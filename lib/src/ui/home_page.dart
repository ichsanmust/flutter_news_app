import 'package:flutter/material.dart';
import 'package:division/division.dart';

import 'package:news_app/src/ui/news_list.dart';
import 'package:news_app/src/ui/news_headlines.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Parent(
              style: ParentStyle()..margin(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Parent(
                      style: ParentStyle()..padding(all: 5),
                      child: new Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Parent(
                      // style: ParentStyle()..background.color(Colors.red),
                      child: Column(
                        children: <Widget>[
                          Txt('Ichsan Must',
                              style: TxtStyle()
                                ..alignment.topLeft()
                                ..textColor(Colors.white)
                                ..fontWeight(FontWeight.bold)
                                ..fontSize(16)
                                ..padding(top: 10)
                              // ..fontFamily('RobotoMono'),
                              ),
                          Txt(
                            'premium user',
                            style: TxtStyle()
                              ..alignment.topLeft()
                              ..textColor(Colors.white)
                              ..padding(top: 0),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Parent(
                      // style: ParentStyle()
                      //   ..background.color(Colors.red)
                      //   ..borderRadius(all: 100),
                      child: Icon(Icons.search),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Parent(
                      // style: ParentStyle()
                      //   ..background.color(Colors.red)
                      //   ..borderRadius(all: 100),
                      child: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: CarouselSlider(
                height: 100.0,
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return NewsHeadlines();
                    },
                  );
                }).toList(),
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
              )),
          Expanded(
            flex: 7,
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(200),
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Technology',
                      ),
                      Tab(
                        text: 'Business',
                      ),
                      Tab(
                        text: 'Science',
                      ),
                      Tab(
                        text: 'sports',
                      ),
                      Tab(
                        text: 'Entertainment',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    NewsList(),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                    Icon(Icons.directions_bike),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
