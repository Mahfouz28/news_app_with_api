import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_with_api/cubit/home_page_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_text_field.dart';

class LatestHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;

  const LatestHeader({
    super.key,
    this.title = 'Latest',
    this.actionText = 'See all',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          CustomTextField(
            hintText: 'Search',
            fieldName: '',
            suffixIcon: Icons.analytics_outlined,
            prefixicone: Icons.search,
            onChange: (value) {
              context.read<HomePageCubit>().getNews(value);
            },
          ),

          8.verticalSpace,

          // Title and Action Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onActionTap,
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w200,
                    color: const Color(0xff4E4B66),
                  ),
                ),
              ),
            ],
          ),

          8.verticalSpace,
        ],
      ),
    );
  }
}
