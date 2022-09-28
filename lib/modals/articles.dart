import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_assignment6/providers/provider_data.dart';

class Articles {
  late String authorName;
  late String dateTime;
  late String description;
  late String imageUrl;
  late String title;
  Articles(
      {required this.authorName,
      required this.dateTime,
      required this.description,
      required this.imageUrl,
      required this.title});

  Articles.fromJson(Map<String, dynamic> json) {
    authorName = json['authorName'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    dateTime = json['dateTime'];
  }

  static Map<String, dynamic> toJson(Articles articles) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['authorName'] = articles.authorName;
    data['description'] = articles.description;
    data['imageUrl'] = articles.imageUrl;
    data['title'] = articles.title;
    data['dateTime'] = DateFormat.yMMMd().format(DateTime.now());
    return data;
  }
}
