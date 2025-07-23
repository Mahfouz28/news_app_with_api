import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_with_api/cubit/home_page_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app_with_api/features/auth/ui/signun/cubit/cubit/signup_cubit_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/login/cubit/cubit/login_cubit_cubit.dart';
import 'package:news_app_with_api/features/onboarding/ui/cubit/cubit/on_boarding_cubit_cubit.dart';
import 'package:news_app_with_api/features/splash_screen/splashscreen.dart';
import 'package:news_app_with_api/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<OnBoardingCubit>(create: (_) => OnBoardingCubit()),
        BlocProvider<HomePageCubit>(create: (_) => HomePageCubit()),
        BlocProvider<SignupCubit>(create: (_) => SignupCubit()),
        BlocProvider<LoginCubitCubit>(create: (_) => LoginCubitCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const MaterialApp(
          home: Splashscreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
