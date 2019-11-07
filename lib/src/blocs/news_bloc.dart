import 'package:flutter/material.dart';

import 'package:news_app/src/models/news_model.dart';
import 'package:news_app/src/resources/news_data_provider.dart';

class NewsBloc with ChangeNotifier {
  final bloc = NewsDataProvider();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }

  NewsBloc() {
    getNews();
  }

  Future<dynamic> _newsFuture;
  Future<dynamic> get newsFuture => _newsFuture;
  NewsModel _newsData;
  NewsModel get newsData => _newsData;
  Future<void> getNews({onPullRequest: false, type : 'top-headlines', country : 'us', category:'technology', pageSize : 5, page : 1}) async {
    if (onPullRequest == false) {
      _isLoading = true;
      notifyListeners();
    }

    // print(type);
    // print(category);
    _newsFuture = bloc.getNews(
      type: type,
      category: category,
      country: country,
      page: pageSize,
      pageSize: pageSize,
    );
    _newsData = await _newsFuture;

    if (onPullRequest == false) {
      _isLoading = false;
    }

    notifyListeners();
    return _newsData;
  }


  Future<dynamic> _newsFutureHeadlines ;
  Future<dynamic> get newsFutureHeadlines => _newsFutureHeadlines;
  NewsModel _newsDataHeadlines;
  NewsModel get newsDataHeadlines => _newsDataHeadlines;
  Future<void>getNewsDataHeadlines({onPullRequest: false, type : 'everything', pageSize : 5, page : 1, q : 'tech'}) async {
    _newsFutureHeadlines = bloc.getNews(
      type: type,
      page: pageSize,
      pageSize: pageSize,
      q : q,
    );
    _newsDataHeadlines = await _newsFutureHeadlines;

    notifyListeners();
    // return _newsDataHeadlines;
  }


}
