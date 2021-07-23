



import 'dart:convert';

import 'package:http/http.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';

abstract class AbstractNews {
  Future<List<NewsModel>> getNews();

}





class NewsImpl implements AbstractNews {
  Client client = Client();

  @override
  Future<List<NewsModel>> getNews() async {

    List<NewsModel> newsModel = [];
    final String uri = "https://newsapi.org/v2/top-headlines?country=us&apiKey=8e33ee34c7384342975e83dc319e18e8";
    var url = Uri.parse(uri);

    try {
      var response = await client.get(url);
      print(response.body);
      int statusCode = response.statusCode;
        if(statusCode == 200){
          (jsonDecode(response.body)['articles'] as List).forEach((dat) {
         return   newsModel.add(NewsModel.fromJson(dat));
          });

        }
    } catch (error) {

    }
    return  newsModel;
  }


}
