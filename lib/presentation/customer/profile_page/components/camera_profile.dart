import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/auth_repository.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_event.dart';

class CameraProfileHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Gagal mengambil gambar: $e");
      }
    }
    return null;
  }

  Future<void> showImageSourceActionSheet({
    required BuildContext context,
    required Function(File file) onImageSelected,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil dari Kamera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final file = await pickImage(context, ImageSource.camera);
                  if (file != null) onImageSelected(file);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final file = await pickImage(context, ImageSource.gallery);
                  if (file != null) onImageSelected(file);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> uploadProfileImage({
    required BuildContext context,
    required File imageFile,
    required VoidCallback onSuccess,
    required Function(String error) onError,
  }) async {
    final authRepo = context.read<AuthRepository>();
    final result = await authRepo.uploadProfileImage(imageFile);
    result.fold((error) => onError(error), (_) {
      onSuccess();
      context.read<GetProfileBloc>().add(LoadProfileEvent());
    });
  }
}
