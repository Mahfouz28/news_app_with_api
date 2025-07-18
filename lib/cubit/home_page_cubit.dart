import 'package:bloc/bloc.dart';
import 'package:news_app_with_api/core/constanis/endpoint_constants%20(1).dart';
import 'package:news_app_with_api/core/network/dio_client.dart';
import 'package:news_app_with_api/cubit/home_page_state.dart';
import 'package:news_app_with_api/model/news_model.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  final dio = DioClient();
  List<NewsModel> news = [];
  getNews(String query) async {
    emit(HomeLoading());

    final now = DateTime.now();
    final from = now
        .subtract(const Duration(days: 30))
        .toIso8601String()
        .substring(0, 10); // "2025-07-13"
    final to = now.toIso8601String().substring(0, 10); // "2025-07-14"

    try {
      var response = await dio.get(
        EndpointConstants.everything,
        queryParameters: {
          "q": query,
          "from": from,
          "to": to,
          "sortBy": "publishedAt",
          "apiKey": EndpointConstants.apiKey,
        },
      );

      news = (response.data['articles'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();

      emit(HomeSuccess(news));
    } catch (e) {
      print("Error : $e");
    }
  }

  getNewsByCategory(String category) async {
    emit(HomeLoading());

    try {
      final queryParameters = {
        "apiKey": EndpointConstants.apiKey,
        "country": "us", 
      };

      if (category.toLowerCase() != 'all') {
        queryParameters['category'] = category.toLowerCase();
      }

      var response = await dio.get(
        EndpointConstants.topHeadlines,
        queryParameters: queryParameters,
      );

      news = (response.data['articles'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();

      emit(HomeSuccess(news));
    } catch (e) {
      print("Error : $e");
      emit(HomeError(e.toString())); // يُفضل إرسال الخطأ
    }
  }
}
