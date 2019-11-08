import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:news_app/src/blocs/news_bloc.dart';
// import 'package:news_app/src/models/news_model.dart';
// import 'package:news_app/src/resources/news_data_provider.dart';

import 'package:news_app/src/ui/news_list.dart';
import 'package:news_app/src/ui/news_headlines.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/src/ui/news_search.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<NewsBloc>(context)
        .getNewsDataHeadlines(q: 'indonesia tech')); // on initiate
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ini contoh pengesetan data nya di ui, boleh boleh saja tapi lebih bagus di bloc / controller
    final newsBlocData = Provider.of<NewsBloc>(context);
    List<Widget> newsHeadlines = [
      Center(child: CircularProgressIndicator())
    ]; // initiale
    if (newsBlocData.newsDataHeadlines != null) {
      newsHeadlines.clear();
      for (var item in newsBlocData.newsDataHeadlines.article) {
        newsHeadlines.add(NewsHeadlines(
          item: item,
        ));
        // print('as ${item.title}');
      }
    }

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
                  flex: 3,
                  child: Parent(
                    // style: ParentStyle()
                    //   ..background.color(Colors.red)
                    //   ..borderRadius(all: 100),
                    // child: Icon(Icons.search),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      tooltip: 'Search',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsSearch()));
                      },
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Parent(
                //     // style: ParentStyle()
                //     //   ..background.color(Colors.red)
                //     //   ..borderRadius(all: 100),
                //     child: Icon(Icons.more_vert),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildNewsHeadlines(newsHeadlines),
        ),
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
                      text: 'Sports',
                    ),
                    Tab(
                      text: 'Entertainment',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  NewsList(
                    category: 'technology',
                  ),
                  NewsList(
                    category: 'business',
                  ),
                  NewsList(
                    category: 'science',
                  ),
                  NewsList(
                    category: 'sports',
                  ),
                  NewsList(
                    category: 'entertainment',
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    )));
  }
}

Widget _buildNewsHeadlines(newsHeadlines) {
  if (newsHeadlines.isEmpty) {
    return Center(child: CircularProgressIndicator());
  } else {
    return CarouselSlider(
      height: 100.0,
      items: newsHeadlines,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      pauseAutoPlayOnTouch: Duration(seconds: 10),
    );
  }
}
