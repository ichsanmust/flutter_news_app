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

  // Future<NewsModel> getListNews({country : 'us'}) async {
  //   if (await checkInternConnection() == false) {
  //     return NewsModel.error('error', 'No Internet Connection');
  //   }

  //   String url =
  //       '$baseUrl/top-headlines?apiKey=$apiKey&country=$country&&category=technology&pageSize=5&page=1';

  //   // var response = await ioClient.get(url, headers: {
  //   //    'authorization': 'bearer $token'
  //   // });
  //   var response = await http.get(url, headers: {
  //     // 'authorization': 'bearer $token',
  //   });

  //   if (response.statusCode == 200) {
  //     return NewsModel.fromJson(convert.jsonDecode(response.body));
  //   } else {
  //     return NewsModel.error('error', 'Something Wrong');
  //   }
  // }


  Future<NewsModel> getNews({type:'top-headlines', country : 'us', category:'technology', pageSize : 5, page : 1}) async {
    if (await checkInternConnection() == false) {
      return NewsModel.error('error', 'No Internet Connection');
    }

    String url =
        '$baseUrl/$type?apiKey=$apiKey&country=$country&&category=$category&pageSize=$pageSize&page=$page';
    var response = await http.get(url, headers: {
      // 'authorization': 'bearer $token',
    });

    if (response.statusCode == 200) {
      return NewsModel.fromJson(convert.jsonDecode(response.body));
    } else {
      return NewsModel.error('error', 'Something Wrong');
    }
  }
}
