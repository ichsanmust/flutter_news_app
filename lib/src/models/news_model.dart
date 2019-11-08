class NewsModel {
  String _status;
  String _message;
  int _totalResults;
  List<_Article> _articles = [];

  NewsModel.fromJson(Map<String, dynamic> parsedJson) {
    // print(parsedJson['articles'].length);
    _status = parsedJson['status'];
    _totalResults = parsedJson['totalResults'];
    _message = 'Success Get data';
    List<_Article> temp = [];
    for (int i = 0; i < parsedJson['articles'].length; i++) {
      if (parsedJson['articles'][i]['source']['id'] == null) {
        parsedJson['articles'][i]['source']['id'] = '';
      }
      _Article result = _Article(parsedJson['articles'][i]);
      temp.add(result);
    }
    _articles = temp;
  }

  NewsModel.error(status, message) {
    _status = status;
    _message = message;
  }

  String get status => _status;
  String get message => _message;
  List<_Article> get article => _articles;
  int get totalResults => _totalResults;
}

class _Article {
  String _id;
  String _name;
  String _author;
  String _title;
  String _description;
  String _url;
  String _urlToImage;
  String _publishedAt;
  String _content;

  _Article(result) {
    _id = result['source']['id'];
    _name = result['source']['name'];
    _author = result['author'];
    _title = result['title'];
    _description = result['description'];
    _url = result['url'];
    _urlToImage = result['urlToImage'];
    _publishedAt = result['publishedAt'];
    _content = result['content'];
  }

  String get id => _id;
  String get name => _name;
  String get author => _author;
  String get title => _title;
  String get description => _description;
  String get url => _url;
  String get urlToImage => _urlToImage;
  String get publishedAt => _publishedAt;
  String get content => _content;

  set id(String id) {
    _id = id;
  }

  set name(String name) {
    _name = name;
  }

  set author(String author) {
    _author = author;
  }

  set title(String title) {
    _title = title;
  }

  set description(String description) {
    _description = description;
  }

  set url(String url) {
    _url = url;
  }

  set urlToImage(String urlToImage) {
    _urlToImage = urlToImage;
  }

  set publishedAt(String publishedAt) {
    _publishedAt = publishedAt;
  }

  set content(String content) {
    _content = content;
  }
}
