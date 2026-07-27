import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/remote/api/image_upload_service.dart';

sealed class ImageUploadState {
  const ImageUploadState();
}

class ImageUploadIdle extends ImageUploadState {
  const ImageUploadIdle();
}

class ImageUploadLoading extends ImageUploadState {
  const ImageUploadLoading();
}

class ImageUploadSuccess extends ImageUploadState {
  const ImageUploadSuccess({required this.imageUrl});
  final String? imageUrl;
}

class ImageUploadError extends ImageUploadState {
  const ImageUploadError({required this.message});
  final String message;
}

class ImageUploadNotifier extends StateNotifier<ImageUploadState> {
  ImageUploadNotifier({
    ImageUploadService? service,
    Future<File?> Function()? imagePicker,
  })  : _service = service ?? ImageUploadService(),
        _imagePicker = imagePicker ?? _defaultImagePicker,
        super(const ImageUploadIdle());

  final ImageUploadService _service;
  final Future<File?> Function() _imagePicker;

  static Future<File?> _defaultImagePicker() async => null;

  Future<File?> _pickImage() async {
    return _imagePicker();
  }

  Future<void> _handleUpload(Future<String?> Function(File) upload) async {
    try {
      final file = await _pickImage();
      if (file == null) return;

      state = const ImageUploadLoading();

      final imageUrl = await upload(file);
      state = ImageUploadSuccess(imageUrl: imageUrl);
    } on ImageUploadException catch (e) {
      state = ImageUploadError(message: e.message);
    } catch (e) {
      state = ImageUploadError(
        message: 'Error inesperado: ${e.toString()}',
      );
    }
  }

  Future<void> pickAndUploadProductImage(int productId) async {
    await _handleUpload(
      (file) => _service.uploadProductImage(productId: productId, file: file),
    );
  }

  Future<void> pickAndUploadAvatar() async {
    await _handleUpload(
      (file) => _service.uploadAvatar(file: file),
    );
  }

  void reset() => state = const ImageUploadIdle();
}

final imageUploadProvider =
    StateNotifierProvider.autoDispose<ImageUploadNotifier, ImageUploadState>(
  (ref) => ImageUploadNotifier(),
);
