import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_api/features/auth/ui/login/cubit/cubit/login_cubit_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/login/screen/login_screen.dart';

import 'package:news_app_with_api/features/onboarding/ui/cubit/cubit/on_boarding_cubit_cubit.dart';

class Lowerpage extends StatelessWidget {
  const Lowerpage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(4)),
                  ),
                ),
                child: Text(
                  cubit.state != 2 ? "Next" : "Get started",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () => cubit.previousPage(),
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(4)),
              ),
            ),
            child: const Text(
              "Back",
              style: TextStyle(color: Color(0xffB0B3B8)),
            ),
          ),

          const Spacer(),
          BlocBuilder<OnBoardingCubit, int>(
            builder: (context, state) {
              return Row(
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: state == index ? Colors.blue : Colors.grey[400],
                      borderRadius: BorderRadius.circular(4),
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
