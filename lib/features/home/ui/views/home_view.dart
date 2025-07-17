import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/body.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/category_list.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/custom_app_bar.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/latest_header.dart';
import '../../../../cubit/home_page_cubit.dart';
import '../../../../cubit/home_page_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onAlertPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 16),

            LatestHeader(
              title: "Latest",
              actionText: "See all",
              onActionTap: () {
                print("See all tapped");
              },
            ),
            const SizedBox(height: 10),
            const CategoryList(),
            Expanded(
              child: BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeSuccess) {
                    return ListView.builder(
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final article = state.news[index];
                        return NewsWidget(
                          title: article.title,
                          source: article.source.name,
                          category: "General",
                          imageUrl: article.urlToImage ?? '',
                          timestamp: article.publishedAt ?? 'Unknown time',
                          author: article.author ?? 'Unknown author',
                          onTap: () {},
                        );
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(
                      child: Text("Something went wrong. Try again."),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
