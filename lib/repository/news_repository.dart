import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:my_news_app/models/categories_news_model.dart';
import 'package:my_news_app/models/news_channel_headlines_model.dart';

class NewsRepository{

  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadLinesApi(BuildContext context,String channelName)async{
  String url = "https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=ea7ee17727a94a798ef4bfee24279011";
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
  final body = jsonDecode(response.body);
  return NewsChannelHeadlinesModel.fromJson(body);
  }
  throw Exception("Error");
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(BuildContext context,String category)async{
  String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=ea7ee17727a94a798ef4bfee24279011";
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
  final body = jsonDecode(response.body);
  return CategoriesNewsModel.fromJson(body);
  }
  throw Exception("Error");
  }



}