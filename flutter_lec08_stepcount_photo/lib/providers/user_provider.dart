import 'dart:async';
import 'dart:developer';

import 'package:flutter_lec08_stepcount_photo/models/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  FutureOr<UserProfile> build() {
    return _loadSavedUserProfile();
  }

  Future<UserProfile> _loadSavedUserProfile() async {
    // Load saved user profile
    final prefs = await SharedPreferences.getInstance();
    final savedProfile = prefs.getString('user_profile');
    if (savedProfile != null) {
      try {
        final Map<String, dynamic> json = Map.fromEntries(
          savedProfile.split(',').map((e) {
            final parts = e.split(':');
            return MapEntry(parts[0], parts[1]);
          }),
        );
        final userProfile = UserProfile.fromJson(json);
        return userProfile;
      } catch (e) {
        log('Error loading profile: $e');
      }
    }
    return UserProfile(
      name: '',
      age: 0,
      gender: Gender.other,
      profileImagePath: '',
    );
  }

  Future<void> loadFromJson(String jsonString) async {
    try {
      final Map<String, dynamic> json = Map.fromEntries(
        jsonString.split(',').map((e) {
          final parts = e.split(':');
          return MapEntry(parts[0], parts[1]);
        }),
      );
      final userProfile = UserProfile.fromJson(json);
      state = AsyncData(userProfile);
    } catch (e) {
      log('Error loading profile: $e');
    }
  }

  Future<void> saveProfile(UserProfile profile) async {
    state = AsyncData(profile);
    await _persistProfile();
  }

  Future<void> updateProfile(UserProfile Function(UserProfile) update) async {
    state = const AsyncLoading();
    if (state.value != null) {
      state = AsyncData(update(state.value!));
      await _persistProfile();
    }
  }

  Future<void> updateProfileImage(String imagePath) async {
    state = const AsyncLoading();
    if (state.value != null) {
      state = AsyncData(state.value!.copyWith(profileImagePath: imagePath));
      await _persistProfile();
    } else {
      // Create a temporary profile with just the image
      state = AsyncData(
        UserProfile(
          name: '',
          age: 0,
          gender: Gender.other,
          profileImagePath: imagePath,
        ),
      );
      await _persistProfile();
    }
  }

  Future<void> _persistProfile() async {
    state = const AsyncLoading();
    if (state.value == null) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = state.value!
        .toJson()
        .entries
        .map((e) => '${e.key}:${e.value}')
        .join(',');
    await prefs.setString('user_profile', jsonString);
  }

  void clearProfile() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('user_profile');
    });
  }

  bool get hasProfile => state.value != null && state.value!.name.isNotEmpty;
}

final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile>(
      UserProfileNotifier.new,
    );
