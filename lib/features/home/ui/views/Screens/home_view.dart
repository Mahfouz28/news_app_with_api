import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_with_api/features/home/ui/views/Screens/details_page.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/body.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/category_list.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/custom_app_bar.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/latest_header.dart';
import '../../../../../cubit/home_page_cubit.dart';
import '../../../../../cubit/home_page_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onAlertPressed: () {}),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,

            /// Trending Header
            LatestHeader(
              title: "Trending",
              actionText: "See all",
              onActionTap: () {
                print("See all tapped");
              },
            ),

            12.verticalSpace,

            /// Trending News Card (1 item)
            SizedBox(
              height: 420.h,
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
                        margin: EdgeInsets.only(right: 12.w),
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          article.urlToImage?.isNotEmpty == true
                                          ? article.urlToImage!
                                          : "https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg",
                                      height: 240.h,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Flexible(
                                            child: Container(
                                              height: 240.h,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.broken_image_outlined,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),

                              ),
                              6.verticalSpace,
                              Flexible(
                                child: Text(
                                  article.source.name,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              4.verticalSpace,
                              Flexible(
                                child: Text(
                                  article.description ??
                                      'No description available',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              4.verticalSpace,
                              if (article.author != null &&
                                  article.author!.isNotEmpty)
                                Flexible(
                                  child: Text(
                                    article.author!,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black54,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14.sp,
                                    color: Colors.black54,
                                  ),
                                  4.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                      article.publishedAt ?? 'Unknown time',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.more_horiz, size: 18.sp),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Lottie.asset("assets/No-Data.json"));
                  }
                },
              ),
            ),

            6.verticalSpace,

            /// All News Header
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All News",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "See all",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w200,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),

            8.verticalSpace,

            CategoryList(
              onCategorySelected: (category) {
                context.read<HomePageCubit>().getNewsByCategory(category);
              },
            ),
            8.verticalSpace,

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
                        padding: EdgeInsets.only(bottom: 12.h),
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

            24.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
