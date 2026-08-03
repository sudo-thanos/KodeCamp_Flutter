import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../services/storage_service.dart';

class ProfileController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();
  final ImagePicker _imagePicker = ImagePicker();

  final editFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final bioController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  final profileImagePath = ''.obs;
  final isSaving = false.obs;
  final fullName = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final dateOfBirth = ''.obs;
  final bio = ''.obs;
  DateTime? selectedDate;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    fullNameController.text = _storage.getFullName();
    emailController.text = _storage.getEmail();
    phoneNumberController.text = _storage.getPhoneNumber();
    bioController.text = _storage.getBio();
    dateOfBirthController.text = _storage.getDateOfBirth();
    profileImagePath.value = _storage.getProfileImagePath();

    fullName.value = fullNameController.text;
    email.value = emailController.text;
    phoneNumber.value = phoneNumberController.text;
    dateOfBirth.value = dateOfBirthController.text;
    bio.value = bioController.text;
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
      dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  Future<void> pickProfileImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }

  ImageProvider? get profileImageProvider {
    if (profileImagePath.value.isEmpty) return null;
    return FileImage(File(profileImagePath.value));
  }

  Future<void> saveProfile() async {
    if (!(editFormKey.currentState?.validate() ?? false)) return;

    isSaving.value = true;
    try {
      await _storage.saveProfileDetails(
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        bio: bioController.text,
        dateOfBirth: dateOfBirthController.text,
        profileImagePath: profileImagePath.value,
      );
      Get.back();
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile: $e');
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    bioController.dispose();
    dateOfBirthController.dispose();
    super.onClose();
  }
}
