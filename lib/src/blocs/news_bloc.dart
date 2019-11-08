import 'package:flutter/material.dart';
import 'package:news_app/src/components/debouncer.dart';

import 'package:news_app/src/models/news_model.dart';
import 'package:news_app/src/resources/news_data_provider.dart';

class NewsBloc with ChangeNotifier {
  final bloc = NewsDataProvider();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // NewsBloc() {
  //   getNews();
  // }

  // news category
  Future<dynamic> _newsFuture;
  Future<dynamic> get newsFuture => _newsFuture;
  NewsModel _newsData;
  NewsModel get newsData => _newsData;
  Future<void> getNews(
      {onPullRequest: false,
      type: 'top-headlines',
      country: 'id',
      category: 'technology',
      pageSize: 5,
      page: 1}) async {
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
      page: page,
      pageSize: pageSize,
    );
    _newsData = await _newsFuture;

    if (onPullRequest == false) {
      _isLoading = false;
    }

    notifyListeners();
    // return _newsData;
  }

  // news headline
  Future<dynamic> _newsFutureHeadlines;
  Future<dynamic> get newsFutureHeadlines => _newsFutureHeadlines;
  NewsModel _newsDataHeadlines;
  NewsModel get newsDataHeadlines => _newsDataHeadlines;
  Future<void> getNewsDataHeadlines(
      {onPullRequest: false,
      type: 'everything',
      pageSize: 5,
      page: 1,
      q: 'indonesia tech'}) async {
    _newsFutureHeadlines = bloc.getNews(
      type: type,
      page: page,
      pageSize: pageSize,
      q: q,
    );
    _newsDataHeadlines = await _newsFutureHeadlines;

    notifyListeners();
    // return _newsDataHeadlines;
  }

  // news search
  TextEditingController _searchController = new TextEditingController();
  TextEditingController get searchController => _searchController;

  Future<dynamic> _newsFutureSearch;
  Future<dynamic> get newsFutureSearch => _newsFutureSearch;
  NewsModel _newsDataSearch;
  NewsModel get newsDataSearch => _newsDataSearch;
  List tempNewsHeadsearch = [];

  int _pageVal = 1;
  int get pageVal => _pageVal;

  void setSearchController(value) {
    _searchController.text = value;
    notifyListeners();
  }

  String _qBefore = '';
  String get qBefore => _qBefore;
  Future<void> onSearchTextChanged(
      {isNeedLoader: true,
      type: 'everything',
      pageSize: 5,
      page: 1,
      q: 'indonesia tech'}) async {
    // print(p);
    if (q == '') {
      // jika query null reset
      _pageVal = 1;
      _newsDataSearch = null;
      tempNewsHeadsearch.clear();
      notifyListeners();
      return _newsDataSearch;
    }
    if (q != qBefore) {
      // query baru
      _pageVal = 1;
      page = 1; //ovveride
      // print('haha');
      // notifyListeners();
    }
    if (isNeedLoader == true) {
      _isLoading = true;
      notifyListeners();
    }

    // print(qBefore);
    // print(q);
    _newsFutureSearch = bloc.getNews(
      type: type,
      page: page,
      pageSize: pageSize,
      q: 'indonesia $q',
    );
    _newsDataSearch = await _newsFutureSearch;

    // ini contoh pengesetan data nya di bloc, jadi ui terima data yang telah jadi
    if (_newsDataSearch.status == 'ok') {
      if (q == qBefore) {
        // artinya call next page
        tempNewsHeadsearch.addAll(_newsDataSearch.article);
      } else {
        // artinya new query
        tempNewsHeadsearch.clear();
        tempNewsHeadsearch.addAll(_newsDataSearch.article);
      }
      _pageVal++;
    } else {
      _pageVal = 1;
      tempNewsHeadsearch.clear();
    }

    if (isNeedLoader == true) {
      _isLoading = false;
    }

    _qBefore = q;
    notifyListeners();
    return _newsDataSearch;
  }

  final debouncer = Debouncer(milliseconds: 500);
  double listViewItemHeight = 50.0;

  void setEmptySearchController() {
    _searchController.text = '';
    _qBefore = '';
    _pageVal = 1;
    tempNewsHeadsearch.clear();
    notifyListeners();
  }
}
