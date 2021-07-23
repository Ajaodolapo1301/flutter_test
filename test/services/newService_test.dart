import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:morphosis_flutter_demo/services/newsService.dart';
import 'dart:convert';
import 'package:http/testing.dart';



void main() {
  test("news from api", () async {
    NewsImpl newsImpl = NewsImpl();
    newsImpl.client = MockClient((request) async {
      final mapJson = {'title':"mytitle"};
      return Response(jsonEncode(mapJson), 200);
    });
  final newsModel = await newsImpl.getNews();

    expect(newsModel[0].title, "mytitle");
  });
}
