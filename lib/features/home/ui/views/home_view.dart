import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_with_api/features/home/ui/views/details_page.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/body.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// Trending Header
            LatestHeader(
              title: "Trending",
              actionText: "See all",
              onActionTap: () {
                print("See all tapped");
              },
            ),

            const SizedBox(height: 12),

            /// Trending News Card (1 item)
            SizedBox(
              height: 350, // Increased height
              child: BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(
                      child: Lottie.asset("assets/Loading Dots Blue.json"),
                    );
                  } else if (state is HomeSuccess) {
                    final trendingNews = state.news.take(6).toList();
                    final article = trendingNews[0];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsPage(newsModel: article),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: article.urlToImage != null
                                  ? Image.network(
                                      article.urlToImage!,
                                      height: 200, // Increased image height
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              height: 200,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.broken_image_outlined,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                    )
                                  : Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.broken_image_outlined,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              article.source.name,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              article.description ?? 'No description available',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            if (article.author != null &&
                                article.author!.isNotEmpty)
                              Text(
                                article.author!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    article.publishedAt ?? 'Unknown time',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.more_horiz, size: 18),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Lottie.asset("assets/No-Data.json"));
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            /// All News Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All News",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See all",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// All News List
            BlocBuilder<HomePageCubit, HomePageState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Lottie.asset("assets/Loading Dots Blue.json");
                } else if (state is HomeSuccess) {
                  final allNews = state.news;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allNews.length,
                    itemBuilder: (context, index) {
                      final article = allNews[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: NewsWidget(
                          title: article.title,
                          source: article.source.name,
                          category: "General",
                          imageUrl: article.urlToImage ?? '',
                          timestamp: article.publishedAt ?? 'Unknown time',
                          author: article.author ?? 'Unknown author',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(newsModel: article),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (state is HomeError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
