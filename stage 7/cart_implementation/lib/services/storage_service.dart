import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  // Called once when the service is initialized (before app starts)
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // --- Getters: read saved profile fields ---
  String getFullName() => _prefs.getString('profile_full_name') ?? '';
  String getEmail() => _prefs.getString('profile_email') ?? '';
  String getPhoneNumber() => _prefs.getString('profile_phone') ?? '';
  String getBio() => _prefs.getString('profile_bio') ?? '';
  String getDateOfBirth() => _prefs.getString('profile_dob') ?? '';
  String getProfileImagePath() => _prefs.getString('profile_image_path') ?? '';

  // --- Setter: save all profile fields at once ---
  Future<void> saveProfileDetails({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String bio,
    required String dateOfBirth,
    required String profileImagePath,
  }) async {
    await _prefs.setString('profile_full_name', fullName);
    await _prefs.setString('profile_email', email);
    await _prefs.setString('profile_phone', phoneNumber);
    await _prefs.setString('profile_bio', bio);
    await _prefs.setString('profile_dob', dateOfBirth);
    await _prefs.setString('profile_image_path', profileImagePath);
  }
}
