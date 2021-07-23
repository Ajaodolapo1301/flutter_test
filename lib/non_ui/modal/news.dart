

import 'package:hive/hive.dart';

part 'news.g.dart';

@HiveType(typeId: 0)
class NewsModel{
  @HiveField(0)
  String author;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String url;
  @HiveField(4)
  String urlToImage;

  @HiveField(5)
  String publishedAt;
  @HiveField(6)
  String content;

  NewsModel({ this.author, this.title,  this.content, this.description,  this.publishedAt,  this.url,  this.urlToImage});

  NewsModel.fromJson(Map <String,  dynamic> json){
    author =  json['author'];
    title = json["title"];

    description =  json['description'];
    url = json["url"];
    urlToImage =  json['urlToImage'];
    publishedAt = json["publishedAt"];
  }
}