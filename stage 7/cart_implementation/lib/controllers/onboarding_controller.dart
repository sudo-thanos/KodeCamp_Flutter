import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/slide_model.dart';

class OnboardingController extends GetxController {
  var currentSlide = 0.obs;
  late PageController pageController;

  final List<Slide> slides = [
    Slide(
      title: 'Discover Recipes',
      description:
          'Explore thousands of delicious recipes from around the world',
      icon: 'assets/bowl.png',
    ),
    Slide(
      title: 'Cook Easily',
      description: 'Step-by-step instructions make cooking simple and fun',
      icon: 'assets/cook.png',
    ),
    Slide(
      title: 'Share & Connect',
      description: 'Share your creations with friends and family',
      icon: 'assets/connect.png',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextSlide() {
    if (currentSlide.value < slides.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void finishOnboarding() {
    Get.offNamed('/auth');
  }
}
