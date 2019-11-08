import 'package:news_app/src/models/news_model.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;

// import 'package:http/io_client.dart';
// HttpClient httpClient = new HttpClient()
//   ..badCertificateCallback =
//       ((X509Certificate cert, String host, int port) => true);

class NewsDataProvider {
  // IOClient ioClient = new IOClient(httpClient);

  final apiKey = 'b978e6b9f4b04bcba813336a802a6651';
  final baseUrl = "https://newsapi.org/v2";

  Future<bool> checkInternConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        return true;
      }
    } on SocketException catch (_) {
      // print('not connected');
      return false;
    }
    return false;
  }

  Future<NewsModel> getNews({type:'top-headlines', country : 'us', category:'technology', pageSize : 5, page : 1, q : 'tech'}) async {
    if (await checkInternConnection() == false) {
      return NewsModel.error('error', 'No Internet Connection');
    }

    String url = '';
    if(type == 'top-headlines'){
        url =
        '$baseUrl/$type?apiKey=$apiKey&country=$country&&category=$category&pageSize=$pageSize&page=$page';
    }else{
      url =
        '$baseUrl/$type?apiKey=$apiKey&q=$q&pageSize=$pageSize&page=$page';
   
    }
    // print(q);
     var response = await http.get(url, headers: {
      // 'authorization': 'bearer $token',
    });

    // print(response.body);
    if (response.statusCode == 200) {
      return NewsModel.fromJson(convert.jsonDecode(response.body));
    } else {
      return NewsModel.error('error', 'Something Wrong');
    }
  }
}
