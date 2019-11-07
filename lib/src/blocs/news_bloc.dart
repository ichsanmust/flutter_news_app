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
  Future<void> getNews({onPullRequest: false}) async {
    if (onPullRequest == false) {
      _isLoading = true;
      notifyListeners();
    }

    _newsFuture = bloc.getNews();
    _newsData = await _newsFuture;

    if (onPullRequest == false) {
      _isLoading = false;
    }

    notifyListeners();
    return _newsData;
  }
}
