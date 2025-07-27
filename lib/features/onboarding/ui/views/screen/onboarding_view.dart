import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_api/features/onboarding/ui/cubit/cubit/on_boarding_cubit_cubit.dart';
import 'package:news_app_with_api/features/onboarding/ui/views/widgets/lower.dart';
import 'package:news_app_with_api/features/onboarding/ui/views/widgets/upper.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: cubit.pageController,
              onPageChanged: cubit.changePage,
              children: const [
                BuildPage(
                  title: "Lorem Ipsum is simply\ndummy",
                  description:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  image: "assets/onBording1.png",
                ),
                BuildPage(
                  title: "Lorem Ipsum is simply\ndummy",
                  description:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  image: "assets/onBording2.png",
                ),
                BuildPage(
                  title: "Lorem Ipsum is simply\ndummy",
                  description:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  image: "assets/onBording3.png",
                ),
              ],
            ),
          ),
          const Lowerpage(),
        ],
      ),
    );
  }
}
