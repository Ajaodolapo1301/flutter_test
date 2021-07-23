
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';

abstract class HiveNewsRepoAbstract {
  Future<void> getNewsCached(List <NewsModel> news);

}



class NewsRepo implements HiveNewsRepoAbstract {
  final HiveInterface hive;

  NewsRepo({@required this.hive});

  @override
  Future<void> getNewsCached(List <NewsModel> news) async {

    try {
      final newsBox = await _openBox("news");
      newsBox.put("news", news);
      print("added");
    } catch (e) {
      // throw e;
    }
  }



  Future<Box> _openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (e) {
    // throw e;
    }
  }
}