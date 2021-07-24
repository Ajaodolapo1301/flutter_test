

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/services/newsService.dart';

void main(){
  NewsImpl newsImpl = NewsImpl();
  test("parse news.json", (){
    const jsonString = {"id": 1,  "title" : "mytitle"};
    expect(NewsModel.fromJson(jsonString).title, "mytitle");
  });

  // test("parse news.json over a network", ()async{
  //   final String uri = "https://newsapi.org/v2/top-headlines?country=us&apiKey=8e33ee34c7384342975e83dc319e18e8";
  //   var url = Uri.parse(uri);
  //     final res = await get(url);
  //       if(res.statusCode == 200){
  //
  //         expect(NewsModel.fromJson(jsonDecode(res.body)), isNotNull);
  //       }
  // });
  test("parse news.json", (){
    const jsonString = {"id": 1,  "title" : "mytitle"};
    const taskID = "1";
    expect(Task.fromMap(snapshot: jsonString, taskID: taskID).id, "1");
  });

}