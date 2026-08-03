import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class CheckoutController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  final RxBool isFormValid = false.obs;

  static final RegExp _phoneRegex = RegExp(r'^[0-9+\-\s]{7,15}$');

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(_validate);
    addressController.addListener(_validate);
    phoneController.addListener(_validate);
  }

  void _validate() {
    isFormValid.value =
        nameController.text.trim().length >= 2 &&
        addressController.text.trim().length >= 5 &&
        _phoneRegex.hasMatch(phoneController.text.trim());
  }

  String? validateName(String? value) {
    if (value == null || value.trim().length < 2) {
      return 'Enter your full name';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.trim().length < 5) {
      return 'Enter a delivery address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || !_phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void proceedToPayment() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    Get.toNamed(
      AppRoutes.payment,
      arguments: {
        'name': nameController.text.trim(),
        'address': addressController.text.trim(),
        'phone': phoneController.text.trim(),
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
