import 'package:flutter/material.dart';

enum Gender { male, female, other }

extension GenderExtension on Gender {
  String get displayName {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }
}

class UserProfile {
  final String name;
  final String profileImagePath;
  final int age;
  final Gender gender;
  final double? height; // in cm
  final double? weight; // in kg
  final DateTime? dateOfBirth;

  UserProfile({
    required this.name,
    required this.profileImagePath,
    required this.age,
    required this.gender,
    this.height,
    this.weight,
    this.dateOfBirth,
  });

  UserProfile copyWith({
    String? name,
    String? profileImagePath,
    int? age,
    Gender? gender,
    double? height,
    double? weight,
    DateTime? dateOfBirth,
  }) {
    return UserProfile(
      name: name ?? this.name,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profileImagePath': profileImagePath,
      'age': age,
      'gender': gender.index,
      'height': height,
      'weight': weight,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      profileImagePath: json['profileImagePath'],
      age: int.parse(json['age']),
      gender: Gender.values[int.parse(json['gender'])],
      height: double.parse(json['height']),
      weight: double.parse(json['weight']),
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
    );
  }

  // Calculate BMI
  double? get bmi {
    if (height != null && weight != null) {
      final heightInMeters = height! / 100;
      return weight! / (heightInMeters * heightInMeters);
    }
    return null;
  }

  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue == null) return 'Unknown';

    if (bmiValue < 18.5) return 'Underweight';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Overweight';
    return 'Obese';
  }

  Color get bmiColor {
    final bmiValue = bmi;
    if (bmiValue == null) return Colors.grey;

    if (bmiValue < 18.5) return Colors.blue;
    if (bmiValue < 25) return Colors.green;
    if (bmiValue < 30) return Colors.orange;
    return Colors.red;
  }
}
