import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_with_api/features/auth/ui/signun/cubit/cubit/signup_cubit_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signup() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final email = emailController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      emit(SignupError("All fields are required."));
      return;
    }

    if (password != confirmPassword) {
      emit(SignupError("Passwords do not match."));
      return;
    }

    emit(SignupLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(const Duration(seconds: 1));

      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SignupError("This email is already registered."));
      } else if (e.code == 'weak-password') {
        emit(SignupError("The password is too weak."));
      } else if (e.code == 'invalid-email') {
        emit(SignupError("The email address is invalid."));
      } else {
        emit(SignupError(e.message ?? "Signup failed."));
      }
    } catch (e) {
      emit(SignupError("Unexpected error: $e"));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
