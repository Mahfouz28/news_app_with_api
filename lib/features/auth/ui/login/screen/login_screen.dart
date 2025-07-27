import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:news_app_with_api/cubit/home_page_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/login/cubit/cubit/login_cubit_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/signun/screen/signup_screen.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/CustomTextButton.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_checkbox.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_text_field.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/socialloginsection.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/upper_siginin.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/bottomnav.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubitCubit>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignInHeader(
                  title: 'Hello',
                  color: Colors.black,
                  title1: '\nAgain!',
                  color1: Colors.blue,
                  suptitel: 'Welcome back you’ve\nbeen missed',
                ),
                SizedBox(height: 16.h),

                // Email Field
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                  controller: loginCubit.emailController,
                  hintText: 'Enter your email',
                  fieldName: 'Email',
                  isPassword: false,
                ),
                SizedBox(height: 16.h),

                // Password Field
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  controller: loginCubit.passwordController,
                  hintText: 'Enter your password',
                  fieldName: 'Password',
                  isPassword: true,
                ),
                SizedBox(height: 8.h),

                const CustomCheckbox(
                  label: 'Remember me',
                  activeColor: Colors.blue,
                ),
                SizedBox(height: 16.h),

                // BlocListener to handle login logic
                BlocListener<LoginCubitCubit, LoginCubitState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else if (state is LoginSuccess) {
                      // Close the loading dialog
                      Navigator.pop(context);

                      // Trigger fetch news immediately
                      final homeCubit = context.read<HomePageCubit>();
                      homeCubit.getNewsByCategory();

                      // Navigate to BottomNav
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: homeCubit,
                            child: const BottomNav(),
                          ),
                        ),
                      );
                    } else if (state is LoginError) {
                      // Close the loading dialog
                      Navigator.pop(context);

                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          content: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Text(
                                  state.message,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 4),
                        ),
                      );
                    }
                  },
                  child: CustomTextButton(
                    label: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginCubit.loginWithEmail();
                      }
                    },
                  ),
                ),
                SizedBox(height: 50.h),

                // Social login + Sign up link
                SocialLoginSection(
                  facebookLabel: 'Facebook',
                  googleLabel: 'Google',
                  onFacebookTap: () {},
                  onGoogleTap: () {},
                  onSignUpTap: () {},
                  questionText: 'Don’t have an account?',
                  actionText: 'Sign Up',
                  onActionTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SigninScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
