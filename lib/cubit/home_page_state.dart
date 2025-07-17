import '../model/news_model.dart';





abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomeLoading extends HomePageState {}

class HomeSuccess extends HomePageState {
  final List<NewsModel> news;

  HomeSuccess(this.news);
}

class HomeError extends HomePageState {
  final String message;

  HomeError(this.message);
}
