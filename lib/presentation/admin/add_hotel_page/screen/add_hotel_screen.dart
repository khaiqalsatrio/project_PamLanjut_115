import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/components/add_hotel_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/components/add_hotel_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/components/add_hotel_header.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_state.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/screen/home_screen_admin.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/add_hotel_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/google_maps/map_result.dart';

class AddHotelScreen extends StatefulWidget {
  const AddHotelScreen({super.key});

  @override
  State<AddHotelScreen> createState() => _AddHotelScreenState();
}

class _AddHotelScreenState extends State<AddHotelScreen> {
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _kotaController = TextEditingController();
  MapResult? _selectedLocation;

  void _saveHotel() {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tolong lengkapi semua data hotel!")),
      );
      return;
    }

    final request = AddHotelRequestModel(
      namaHotel: _namaController.text.trim(),
      deskripsiHotel: _deskripsiController.text.trim(),
      kota: _kotaController.text.trim(),
      latitude: _selectedLocation!.latitude.toString(),
      longitude: _selectedLocation!.longitude.toString(),
      alamat: _selectedLocation!.address,
    );
    context.read<AddHotelBloc>().add(AddHotelSubmitted(request));
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _kotaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddHotelBloc, AddHotelState>(
      listener: (context, state) {
        if (state is AddHotelSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Hotel berhasil disimpan!")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreenAdmin()),
            (route) => false,
          );
        } else if (state is AddHotelFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Gagal: ${state.error}")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const AddHotelHeader(),
          body: AddHotelBody(
            namaController: _namaController,
            deskripsiController: _deskripsiController,
            kotaController: _kotaController,
            selectedLocation: _selectedLocation,
            onLocationSelected: (loc) {
              setState(() {
                _selectedLocation = loc;
              });
            },
          ),
          bottomNavigationBar: AddHotelFooter(onSavePressed: _saveHotel),
        );
      },
    );
  }
}
