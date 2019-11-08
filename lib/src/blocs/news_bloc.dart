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
    // return _newsData;
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


  TextEditingController _searchController = new TextEditingController();
  TextEditingController get searchController => _searchController;
  ScrollController scrollController = new ScrollController();

  Future<dynamic> _newsFutureSearch ;
  Future<dynamic> get newsFutureSearch => _newsFutureSearch;
  NewsModel _newsDataSearch;
  NewsModel get newsDataSearch => _newsDataSearch;
  List tempNewsHeadsearch = [];

  void setSearchController(value) {
    _searchController.text = value;
    notifyListeners();
  }

  Future<void>onSearchTextChanged({type : 'everything', pageSize : 5, page : 1, q : 'tech'}) async {
      print(q);
      if(q == ''){ // jika query null reset
        _newsDataSearch == null;
         tempNewsHeadsearch.clear();
         notifyListeners();
         return _newsDataSearch;
      }
       _newsFutureSearch = bloc.getNews(
        type: type,
        page: pageSize,
        pageSize: pageSize,
        q : q,
      );
      _newsDataSearch = await _newsFutureSearch;

      if(_newsDataSearch.status == 'ok'){
        if(q == _searchController.text ){ // artinya call next page
          tempNewsHeadsearch.addAll(_newsDataSearch.article);
        }else{ // artinya new query
          tempNewsHeadsearch.clear();
          tempNewsHeadsearch.addAll(_newsDataSearch.article);
        }
      }else{
        tempNewsHeadsearch.clear();
      }

      notifyListeners();
      return _newsDataSearch;
  }
  
  final debouncer = Debouncer(milliseconds: 500);
  double listViewItemHeight = 50.0;

}
