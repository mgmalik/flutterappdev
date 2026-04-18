import 'dart:io';

class CameraState {
  final File? capturedImage;
  final bool isCapturing;
  final String? error;

  CameraState({this.capturedImage, required this.isCapturing, this.error});

  factory CameraState.initial() {
    return CameraState(capturedImage: null, isCapturing: false, error: null);
  }

  CameraState copyWith({
    File? capturedImage,
    bool? isCapturing,
    String? error,
  }) {
    return CameraState(
      capturedImage: capturedImage ?? this.capturedImage,
      isCapturing: isCapturing ?? this.isCapturing,
      error: error,
    );
  }
}
