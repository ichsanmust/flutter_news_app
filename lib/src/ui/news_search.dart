import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/news_bloc.dart';
import 'package:news_app/src/ui/news_card.dart';
import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';

class NewsSearch extends StatefulWidget {
  @override
  _NewsSearchState createState() => _NewsSearchState();
}

class _NewsSearchState extends State<NewsSearch> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          // return _refresh();
        },
        child: _buildBodyWidget(context),
      ),
    );
  }
}

  Widget _buildBodyWidget(context) {
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
                      q : text
                    ));
                  },
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.cancel),
                  onPressed: () {
                    newsBloc.setSearchController('');
                    newsBloc.onSearchTextChanged(
                      q: '',
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: _buildList(context,newsBloc),
        ),
      ],
    );
  }

  Widget _buildList(context, newsBloc){
    var data = newsBloc.tempNewsHeadsearch;
    print(data);
    if (newsBloc.newsDataSearch != null){
        if (newsBloc.newsDataSearch.status == 'ok'){
        if (data.isEmpty == false){
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
                controller: newsBloc.scrollController,
              );
        }else{
          return Container();
        }
      }else{
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Text(newsBloc.newsDataSearch.message)),
            FlatButton(
              color: Colors.deepPurple,
              child: Text('Retry'),
              onPressed: () {
                newsBloc.onSearchTextChanged(
                      q : newsBloc.searchController.text
                    );
              },
            )
          ],
        );
      }
    }else{
      return Container();
    }

  }

  Widget _buildProgressIndicator(context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
           opacity: 1.0 ,
          // opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
