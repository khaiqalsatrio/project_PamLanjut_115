import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/bloc/detail_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/bloc/detail_hotel_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/bloc/detail_hotel_state.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/components/detail_hotel_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/components/detail_hotel_header.dart';

class DetailHotelScreen extends StatefulWidget {
  const DetailHotelScreen({super.key});

  @override
  State<DetailHotelScreen> createState() => _DetailHotelScreenState();
}

class _DetailHotelScreenState extends State<DetailHotelScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    context.read<DetailHotelBloc>().add(LoadDetailHotelEvent());
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      if (kDebugMode) print("❌ Gagal mengambil gambar: $e");
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    setState(() => _isUploading = true);

    final repo = context.read<AdminRepository>();
    final result = await repo.uploadHotelImage(_selectedImage!);

    result.fold(
      (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ Upload gagal: $error")));
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Gambar berhasil diunggah")),
        );
        setState(() {
          _selectedImage = null;
        });
        context.read<DetailHotelBloc>().add(LoadDetailHotelEvent());
      },
    );

    setState(() => _isUploading = false);
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('Pilih dari Galeri'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Ambil dari Kamera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          DetailHotelHeader(onBack: () => Navigator.pop(context)),
          Expanded(
            child: BlocBuilder<DetailHotelBloc, DetailHotelState>(
              builder: (context, state) {
                if (state is DetailHotelLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DetailHotelError) {
                  return Center(child: Text("❌ ${state.message}"));
                } else if (state is DetailHotelLoaded) {
                  final hotel = state.hotel;
                  return DetailHotelBody(
                    selectedImage: _selectedImage,
                    imageBytes: state.imageBytes,
                    isUploading: _isUploading,
                    onUpload: _uploadImage,
                    onPickImage: _showImagePicker,
                    nama: hotel.namaHotel ?? '-',
                    deskripsi: hotel.deskripsiHotel ?? '-',
                    alamat: hotel.alamat ?? '-',
                  );
                } else {
                  return const Center(child: Text("🔍 Tidak ada data hotel"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
