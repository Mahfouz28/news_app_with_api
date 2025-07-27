import 'package:bloc/bloc.dart';
import 'package:news_app_with_api/core/constanis/endpoint_constants%20(1).dart'; // Ensure correct path
import 'package:news_app_with_api/core/network/dio_client.dart'; // Ensure correct path
import 'package:news_app_with_api/cubit/home_page_state.dart'; // Ensure correct path
import 'package:news_app_with_api/model/news_model.dart'; // Ensure correct path

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  final dio = DioClient();
  List<NewsModel> news = [];

  // Method to get news based on a general query
  getNews(String query) async {
    // Emit loading state before starting the operation
    emit(HomeLoading());

    final now = DateTime.now();
    final to = now.toIso8601String().substring(
      0,
      10,
    ); // Get current date in YYYY-MM-DD format

    try {
      // Perform API call
      var response = await dio.get(
        EndpointConstants.everything,
        queryParameters: {
          "q": query,
          "to": to,
          "sortBy": "publishedAt",
          "apiKey": EndpointConstants.apiKey,
        },
      );

      // Map API response to NewsModel list
      news = (response.data['articles'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();

      // Emit success state with the fetched news
      // Add a check to ensure the Cubit is not closed before emitting
      if (!isClosed) {
        // <--- ADDED THIS CHECK
        emit(HomeSuccess(news));
      }
    } catch (e) {
      // Catch any errors during the operation
      print("Error : $e");
      // Emit error state only if the Cubit is not closed
      if (!isClosed) {
        // <--- ADDED THIS CHECK
        emit(HomeError(e.toString()));
      }
    }
  }

  // Method to get news by category (defaulting to 'sports' if no category is provided)
  getNewsByCategory([String category = 'sports']) async {
    // Emit loading state before starting the operation
    emit(HomeLoading());

    try {
      final queryParameters = {
        "apiKey": EndpointConstants.apiKey,
        "sortBy": "publishedAt",
        "language": "en", // Good practice to specify language
      };

      // Adjust query parameter based on category
      if (category.toLowerCase() != 'all') {
        queryParameters['q'] = category;
      } else {
        // If category is 'all', query for general news
        queryParameters['q'] = "news";
      }

      // Perform API call
      final response = await dio.get(
        EndpointConstants.everything,
        queryParameters: queryParameters,
      );

      // Map API response to NewsModel list
      news = (response.data['articles'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();

      // Emit success state with the fetched news
      // Add a check to ensure the Cubit is not closed before emitting
      if (!isClosed) {
        // <--- ADDED THIS CHECK
        emit(HomeSuccess(news));
      }
    } catch (e) {
      // Catch any errors during the operation
      print("Error : $e");
      // Emit error state only if the Cubit is not closed
      if (!isClosed) {
        // <--- ADDED THIS CHECK
        emit(HomeError(e.toString()));
      }
    }
  }
}
