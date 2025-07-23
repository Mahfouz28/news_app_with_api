import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_with_api/features/auth/ui/login/screen/login_screen.dart';
import 'package:news_app_with_api/features/auth/ui/signun/cubit/cubit/signup_cubit_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/signun/cubit/cubit/signup_cubit_state.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/CustomTextButton.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_checkbox.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_text_field.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/socialloginsection.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/upper_siginin.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signupCubit = context.read<SignupCubit>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignInHeader(
                  title: 'Hello!',
                  color: Colors.blue,
                  title1: '',
                  color1: Colors.blue,
                  suptitel: 'Signup to get Started',
                ),
                SizedBox(height: 16.h),

                CustomTextField(
                  controller: signupCubit.emailController,
                  hintText: 'Enter your username',
                  fieldName: 'Username',
                  isPassword: false,
                ),
                SizedBox(height: 16.h),

                CustomTextField(
                  controller: signupCubit.passwordController,
                  hintText: 'Enter your password',
                  fieldName: 'Password',
                  isPassword: true,
                ),
                SizedBox(height: 16.h),

                CustomTextField(
                  controller: signupCubit.confirmPasswordController,
                  hintText: 'Confirm password',
                  fieldName: 'Confirm Password',
                  isPassword: true,
                ),
                SizedBox(height: 16.h),

                const CustomCheckbox(
                  label: 'Remember me',
                  activeColor: Colors.blue,
                ),
                SizedBox(height: 16.h),

                BlocListener<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupLoading) {
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else if (state is SignupSuccess) {
                      Navigator.pop(context); // close the loading dialog

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          content: const Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  'Your account has been created successfully!',
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 4),
                        ),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    } else if (state is SignupError) {
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
                                  style: const TextStyle(color: Colors.white),
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
                    label: 'Sign up',
                    onPressed: () {
                      signupCubit.signup();
                    },
                  ),
                ),

                SizedBox(height: 40.h),

                SocialLoginSection(
                  facebookLabel: 'Facebook',
                  googleLabel: 'Google',
                  onFacebookTap: () {},
                  onGoogleTap: () {},
                  onSignUpTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  questionText: 'Already have an account ? ',
                  actionText: 'Login',
                  onActionTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
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
