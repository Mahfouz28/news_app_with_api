import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_with_api/features/auth/ui/login/cubit/cubit/login_cubit_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/login/screen/login_screen.dart';
import 'package:news_app_with_api/features/onboarding/ui/cubit/cubit/on_boarding_cubit_cubit.dart';

class Lowerpage extends StatelessWidget {
  const Lowerpage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          BlocBuilder<OnBoardingCubit, int>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  cubit.nextPage(4);
                  if (state == 2) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => LoginCubitCubit(),
                          child: LoginScreen(),
                        ),
                      ),
                      (route) => false,
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  ),
                ),
                child: Text(
                  cubit.state != 2 ? "Next" : "Get started",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () => cubit.previousPage(),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
              ),
            ),
            child: Text(
              "Back",
              style: TextStyle(
                color: const Color(0xffB0B3B8),
                fontSize: 14.sp,
              ),
            ),
          ),

          const Spacer(),

          BlocBuilder<OnBoardingCubit, int>(
            builder: (context, state) {
              return Row(
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: state == index ? Colors.blue : Colors.grey[400],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
