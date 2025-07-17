import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_api/cubit/home_page_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/login/cubit/cubit/login_cubit_cubit.dart';
import 'package:news_app_with_api/features/auth/ui/signun/screen/signup_screen.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/CustomTextButton.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_checkbox.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_text_field.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/socialloginsection.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/upper_siginin.dart';
import 'package:news_app_with_api/features/home/ui/views/home_view.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubitCubit>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                const SizedBox(height: 16),

                CustomTextField(
                  controller: loginCubit.emailController,
                  hintText: 'Enter your email',
                  fieldName: 'Email',
                  isPassword: false,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: loginCubit.passwordController,
                  hintText: 'Enter your password',
                  fieldName: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 8),

                const CustomCheckbox(
                  label: 'Remember me',
                  activeColor: Colors.blue,
                ),
                const SizedBox(height: 16),

                /// BlocListener for login
                BlocListener<LoginCubitCubit, LoginCubitState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      showDialog(
                        context: context,

                        builder: (_) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else if (state is LoginSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => HomePageCubit()..getNews('general'),
                            child: const HomeView(),
                          ),
                        ),
                        (route) => false,
                      );
                    } else if (state is LoginError) {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          content: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 14),
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
                    label: 'Login',
                    onPressed: () {
                      loginCubit.loginWithEmail(context);
                    },
                  ),
                ),

                const SizedBox(height: 50),

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
