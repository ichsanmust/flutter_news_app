import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/news_bloc.dart';
import 'package:news_app/src/ui/news_card.dart';

import 'package:provider/provider.dart';

class NewsSearch extends StatefulWidget {
  @override
  _NewsSearchState createState() => _NewsSearchState();
}

class _NewsSearchState extends State<NewsSearch> {
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController = new ScrollController();

  _getMoreData() {
    print('haha');
    Provider.of<NewsBloc>(context).onSearchTextChanged(
      q: Provider.of<NewsBloc>(context).searchController.text,
      isNeedLoader: false,
      page: Provider.of<NewsBloc>(context).pageVal,
    );
  }

  initState() {
    super.initState();
    Future.microtask(() => Provider.of<NewsBloc>(context)
        .setEmptySearchController()); // on initiate
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
        //print('get more');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: _buildBodyWidget(context, _scrollController),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("News"),
//       ),
//       body: RefreshIndicator(
//         key: _refreshIndicatorKey,
//         onRefresh: () {
//           // return _refresh();
//         },
//         child: _buildBodyWidget(context,_scrollController),
//       ),
//     );
//   }
// }

Widget _buildBodyWidget(context, _scrollController) {
  final newsBloc = Provider.of<NewsBloc>(context);
  // print(newsBloc.tempNewsHeadsearch);

  return Column(
    children: <Widget>[
      new Container(
        color: Theme.of(context).primaryColor,
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Card(
            child: new ListTile(
              leading: new Icon(Icons.search),
              title: new TextField(
                controller: newsBloc.searchController,
                decoration: new InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                onChanged: (text) {
                  newsBloc.debouncer.run(() => newsBloc.onSearchTextChanged(
                        q: text,
                        page: Provider.of<NewsBloc>(context).pageVal,
                      ));
                },
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  newsBloc.setSearchController('');
                  newsBloc.onSearchTextChanged(
                    q: '',
                    page: Provider.of<NewsBloc>(context).pageVal,
                  );
                },
              ),
            ),
          ),
        ),
      ),
      Flexible(
        child: _buildList(context, newsBloc, _scrollController),
      ),
    ],
  );
}

Widget _buildList(context, newsBloc, _scrollController) {
  if (newsBloc.isLoading == true) {
    return _buildProgressIndicator(context);
  }
  var data = newsBloc.tempNewsHeadsearch;
  // print(data);
  if (newsBloc.newsDataSearch != null) {
    if (newsBloc.newsDataSearch.status == 'ok') {
      if (data.isEmpty == false) {
        return ListView.builder(
          itemCount: data.length + 1,
          itemBuilder: (context, index) {
            if (index == data.length) {
              return _buildProgressIndicator(context);
            } else {
              var item = data[index];
              return newsCard(context, item);
            }
          },
          controller: _scrollController,
        );
      } else {
        return Container();
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: Text(newsBloc.newsDataSearch.message)),
          FlatButton(
            color: Colors.deepPurple,
            child: Text('Retry'),
            onPressed: () {
              newsBloc.onSearchTextChanged(q: newsBloc.searchController.text);
            },
          )
        ],
      );
    }
  } else {
    return Container();
  }
}

Widget _buildProgressIndicator(context) {
  return new Padding(
    padding: const EdgeInsets.all(8.0),
    child: new Center(
      child: new Opacity(
        opacity: 1.0,
        // opacity: isPerformingRequest ? 1.0 : 0.0,
        child: new CircularProgressIndicator(),
      ),
    ),
  );
}
