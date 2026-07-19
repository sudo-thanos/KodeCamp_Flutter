import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // obs variables
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var showPassword = false.obs;

  // Login
  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password cannot be empty!',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 4), () {
      isLoading.value = false;
      Get.offNamed('/main', arguments: {'email': email});
    });
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
