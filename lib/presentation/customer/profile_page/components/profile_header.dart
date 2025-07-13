import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/core/constants/colors.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/components/camera_profile.dart';

class ProfileHeader extends StatefulWidget {
  final String? nama;
  final String? email;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.nama,
    required this.email,
    this.imageUrl,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _selectedImage;
  bool _isUploading = false;
  final CameraProfileHelper _cameraHelper = CameraProfileHelper();

  void _showImageSourceActionSheet() {
    _cameraHelper.showImageSourceActionSheet(
      context: context,
      onImageSelected: (file) {
        setState(() {
          _selectedImage = file;
        });
      },
    );
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;
    setState(() => _isUploading = true);

    await _cameraHelper.uploadProfileImage(
      context: context,
      imageFile: _selectedImage!,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Foto profil berhasil diunggah")),
        );
        setState(() => _selectedImage = null);
      },
      onError: (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ Gagal upload: $error")));
      },
    );

    setState(() => _isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 130,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 139, 162, 231),
                Color.fromARGB(255, 139, 162, 231),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned.fill(
          top: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _showImageSourceActionSheet,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      image:
                          _selectedImage != null
                              ? DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              )
                              : (widget.imageUrl != null &&
                                  widget.imageUrl!.isNotEmpty)
                              ? DecorationImage(
                                image: NetworkImage(widget.imageUrl!),
                                fit: BoxFit.cover,
                              )
                              : null,
                      color: Colors.white,
                    ),
                    child:
                        (_selectedImage == null &&
                                (widget.imageUrl == null ||
                                    widget.imageUrl!.isEmpty))
                            ? Icon(
                              Icons.person,
                              size: 36,
                              color: AppColors.primary,
                            )
                            : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.nama ?? "-",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 2,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedImage != null && !_isUploading)
                  IconButton(
                    icon: const Icon(
                      Icons.upload,
                      color: Color.fromARGB(255, 54, 54, 54),
                    ),
                    onPressed: _uploadImage,
                  ),
                if (_isUploading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
