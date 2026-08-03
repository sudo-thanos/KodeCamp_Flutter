import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../routes/app_routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    controller.loadProfile();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black87),
            onPressed: () => Get.toNamed(AppRoutes.editProfile),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: controller.profileImagePath.value.isNotEmpty
                      ? FileImage(File(controller.profileImagePath.value))
                      : null,
                  child: controller.profileImagePath.value.isEmpty
                      ? const Icon(Icons.person, size: 55, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 16),

                Text(
                  controller.fullName.value.isNotEmpty
                      ? controller.fullName.value
                      : 'No name set',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  controller.email.value.isNotEmpty
                      ? controller.email.value
                      : 'No email set',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: controller.phoneNumber.value,
                      ),
                      const Divider(height: 24),
                      _buildDetailRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Date of Birth',
                        value: controller.dateOfBirth.value,
                      ),
                      const Divider(height: 24),
                      _buildDetailRow(
                        icon: Icons.info_outline,
                        label: 'Bio',
                        value: controller.bio.value,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.editProfile),
                    icon: const Icon(Icons.edit, color: Colors.teal),
                    label: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'Not set',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
