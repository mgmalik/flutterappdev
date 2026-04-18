import 'dart:async';
import 'dart:io';
import 'package:flutter_lec08_stepcount_photo/models/camera_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

final cameraProvider = AsyncNotifierProvider<CameraNotifier, CameraState>(
  CameraNotifier.new,
);

class CameraNotifier extends AsyncNotifier<CameraState> {
  final ImagePicker _picker = ImagePicker();

  @override
  FutureOr<CameraState> build() async {
    return CameraState(isCapturing: false);
  }

  Future<void> pickImageFromCamera() async {
    state = const AsyncLoading();
    if (state.value == null) {
      state = AsyncData(CameraState(isCapturing: true, error: null));
    } else {
      state = AsyncData(state.value!.copyWith(isCapturing: true, error: null));
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final file = await _saveImageToAppDirectory(File(image.path));
        state = AsyncData(
          state.value!.copyWith(capturedImage: file, error: null),
        );
      }
    } catch (e) {
      state = AsyncData(
        state.value!.copyWith(error: 'Error capturing image: $e'),
      );
    } finally {
      state = AsyncData(state.value!.copyWith(isCapturing: false));
    }
  }

  Future<void> pickImageFromGallery() async {
    state = const AsyncLoading();

    if (state.value == null) {
      state = AsyncData(CameraState(isCapturing: true, error: null));
    } else {
      state = AsyncData(state.value!.copyWith(isCapturing: true, error: null));
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final file = await _saveImageToAppDirectory(File(image.path));
        state = AsyncData(
          state.value!.copyWith(capturedImage: file, error: null),
        );
      }
    } catch (e) {
      state = AsyncData(
        state.value!.copyWith(error: 'Error capturing image: $e'),
      );
    } finally {
      state = AsyncData(state.value!.copyWith(isCapturing: false));
    }
  }

  Future<File> _saveImageToAppDirectory(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await imageFile.copy(path.join(appDir.path, fileName));
    return savedImage;
  }

  void clearImage() {
    state = const AsyncLoading();
    state = AsyncData(state.value!.copyWith(capturedImage: null));
  }
}
