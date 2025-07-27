import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_with_api/cubit/home_page_cubit.dart';
import 'package:news_app_with_api/cubit/home_page_state.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_text_field.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/body.dart';

class BookMark extends StatelessWidget {
  const BookMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            24.verticalSpace,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Bookmark",
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 16.h),

            const CustomTextField(
              hintText: "Searsh",
              prefixicone: Icons.search,
              suffixIcon: Icons.tune_rounded,
              fieldName: '',
            ),

            Expanded(
              child: BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Lottie.asset("assets/Loading Dots Blue.json");
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
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Something went wrong. Try again.",
                        style: TextStyle(fontSize: 16.sp),
                      ),
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
