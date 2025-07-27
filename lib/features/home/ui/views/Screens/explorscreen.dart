import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_with_api/cubit/home_page_cubit.dart';
import 'package:news_app_with_api/cubit/home_page_state.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/body.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/custom_app_bar.dart';

class Explorscreen extends StatelessWidget {
  Explorscreen({super.key});

  final List<String> categories = [
    'All',
    'Sports',
    'Politics',
    'Business',
    'Health',
    'Travel',
    'Science',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CustomAppBar(onAlertPressed: () {}),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              TabBar(
                dividerHeight: 0.h,
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: Colors.grey,
                tabs: categories
                    .map((category) => Tab(text: category))
                    .toList(),
                isScrollable: true,
                onTap: (index) {},
              ),
              SizedBox(height: 10.h),
              SizedBox(height: 8.h),
              Expanded(
                child: TabBarView(
                  children: categories.map((category) {
                    return BlocProvider<HomePageCubit>(
                      create: (context) {
                        final cubit = HomePageCubit();
                        cubit.getNewsByCategory(category);
                        return cubit;
                      },
                      child: BlocBuilder<HomePageCubit, HomePageState>(
                        builder: (context, state) {
                          if (state is HomeLoading) {
                            return Center(
                              child: Lottie.asset(
                                "assets/Loading Dots Blue.json",
                                height: 100.h,
                              ),
                            );
                          } else if (state is HomeSuccess) {
                            return ListView.builder(
                              itemCount: state.news.length,
                              itemBuilder: (context, index) {
                                final article = state.news[index];
                                return NewsWidget(
                                  title: article.title,
                                  source: article.source.name,
                                  category: category,
                                  imageUrl: article.urlToImage ?? '',
                                  timestamp:
                                      article.publishedAt ?? 'Unknown time',
                                  author: article.author ?? 'Unknown author',
                                  onTap: () {},
                                );
                              },
                            );
                          } else if (state is HomeError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "اختر فئة لعرض الأخبار.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
