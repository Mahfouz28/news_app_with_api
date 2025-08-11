import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_with_api/core/network/dio_client.dart';

part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  LoginCubitCubit() : super(LoginCubitInitial());
  final dio = DioClient();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Signin() async {
    try {
      final respose = await dio.post(
        "https//food-api-omega.vercel.app/api/user/signin",
        data: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );
      print(respose);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loginWithEmail() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      emit(LoginError("Please enter both email and password"));
      return;
    }

    emit(LoginLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginError('Incorrect password.'));
      } else {
        emit(LoginError('Error: ${e.message}'));
      }
    } catch (e) {
      emit(LoginError('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
