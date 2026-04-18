import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lec08_stepcount_photo/models/user_profile.dart';
import 'package:flutter_lec08_stepcount_photo/providers/camera_provider.dart';
import 'package:flutter_lec08_stepcount_photo/providers/step_provider.dart';
import 'package:flutter_lec08_stepcount_photo/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _dobController;

  Gender _selectedGender = Gender.male;
  DateTime? _selectedDate;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider).value;

    _nameController = TextEditingController(text: profile?.name ?? '');
    _ageController = TextEditingController(text: profile?.age.toString() ?? '');
    _heightController = TextEditingController(
      text: profile?.height?.toString() ?? '',
    );
    _weightController = TextEditingController(
      text: profile?.weight?.toString() ?? '',
    );
    _dobController = TextEditingController(
      text: profile?.dateOfBirth != null
          ? _formatDate(profile!.dateOfBirth!)
          : '',
    );

    if (profile != null) {
      _selectedGender = profile.gender;
      _selectedDate = profile.dateOfBirth;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = _formatDate(picked);

        // Calculate age
        final age = DateTime.now().year - picked.year;
        _ageController.text = age.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraProvider).value;
    final profile = ref.watch(userProfileProvider).value;
    final stepState = ref.watch(stepProvider).value;
    final hasProfile = ref.read(userProfileProvider.notifier).hasProfile;

    return Scaffold(
      appBar: AppBar(
        title: Text(hasProfile ? 'Profile' : 'Create Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        actions: [
          if (hasProfile && !_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              tooltip: 'Edit Profile',
            ),
          if (_isEditing || !hasProfile)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveProfile,
              tooltip: 'Save Profile',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Image
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                          cameraState != null &&
                              cameraState.capturedImage != null
                          ? FileImage(cameraState.capturedImage!)
                          : (profile != null
                                ? (profile.profileImagePath.isNotEmpty
                                      ? FileImage(
                                          File(profile.profileImagePath),
                                        )
                                      : null)
                                : null),
                      child: cameraState == null
                          ? (profile == null
                                ? (profile!.profileImagePath.isEmpty
                                      ? const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        )
                                      : null)
                                : null)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 40.0,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          onPressed: () {
                            context.push('/camera');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Profile Form
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name
                      TextFormField(
                        controller: _nameController,
                        enabled: _isEditing || !hasProfile,
                        decoration: const InputDecoration(
                          labelText: 'Full Name *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Gender Selection
                      InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Gender *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.wc),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Gender>(
                            value: _selectedGender,
                            isDense: true,
                            onChanged: (_isEditing || !hasProfile)
                                ? (Gender? newValue) {
                                    setState(() {
                                      _selectedGender = newValue!;
                                    });
                                  }
                                : null,
                            items: Gender.values.map((Gender gender) {
                              return DropdownMenuItem<Gender>(
                                value: gender,
                                child: Text(gender.displayName),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Date of Birth
                      TextFormField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.cake),
                          suffixIcon: (_isEditing || !hasProfile)
                              ? IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context),
                                )
                              : null,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Age (auto-calculated)
                      TextFormField(
                        controller: _ageController,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.numbers),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Physical Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Height and Weight Row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _heightController,
                              enabled: _isEditing || !hasProfile,
                              decoration: const InputDecoration(
                                labelText: 'Height (cm)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.height),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              enabled: _isEditing || !hasProfile,
                              decoration: const InputDecoration(
                                labelText: 'Weight (kg)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.monitor_weight),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),

                      if (profile?.bmi != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: profile!.bmiColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: profile.bmiColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'BMI:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                profile.bmi!.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: profile.bmiColor,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: profile.bmiColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  profile.bmiCategory,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              if (hasProfile && !_isEditing) ...[
                const SizedBox(height: 20),

                // Profile Summary Card
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person, color: Colors.blue),
                          title: const Text('Name'),
                          subtitle: Text(profile!.name),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.wc, color: Colors.blue),
                          title: const Text('Gender'),
                          subtitle: Text(profile.gender.displayName),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.cake, color: Colors.blue),
                          title: const Text('Age'),
                          subtitle: Text('${profile.age} years'),
                        ),
                        if (profile.height != null) ...[
                          const Divider(),
                          ListTile(
                            leading: const Icon(
                              Icons.height,
                              color: Colors.blue,
                            ),
                            title: const Text('Height'),
                            subtitle: Text('${profile.height} cm'),
                          ),
                        ],
                        if (profile.weight != null) ...[
                          const Divider(),
                          ListTile(
                            leading: const Icon(
                              Icons.monitor_weight,
                              color: Colors.blue,
                            ),
                            title: const Text('Weight'),
                            subtitle: Text('${profile.weight} kg'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final profile = UserProfile(
        name: _nameController.text,
        profileImagePath: ref.read(cameraProvider).value!.capturedImage!.path,
        age: int.parse(_ageController.text),
        gender: _selectedGender,
        height: _heightController.text.isNotEmpty
            ? double.parse(_heightController.text)
            : null,
        weight: _weightController.text.isNotEmpty
            ? double.parse(_weightController.text)
            : null,
        dateOfBirth: _selectedDate,
      );

      await ref.read(userProfileProvider.notifier).saveProfile(profile);

      // Update step calculations with new profile data
      ref.read(stepProvider.notifier).updateUserProfile(profile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully')),
        );

        setState(() {
          _isEditing = false;
        });

        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/home');
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
