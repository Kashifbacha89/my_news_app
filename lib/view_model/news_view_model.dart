import 'package:my_news_app/models/categories_news_model.dart';
import 'package:my_news_app/models/news_channel_headlines_model.dart';

import '../repository/news_repository.dart';
import 'package:flutter/material.dart';

class NewsViewModel{
  final _repo=NewsRepository();
  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadLinesApi(BuildContext context,String channelName)async{
    final response = await _repo.fetchNewChannelHeadLinesApi(context,channelName);
    return response;
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(BuildContext context,String categoryName)async{
    final response = await _repo.fetchCategoriesNewsApi(context,categoryName);
    return response;
  }


}