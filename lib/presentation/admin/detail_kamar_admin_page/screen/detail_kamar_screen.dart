import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/update_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/bloc/delete_kamar/delete_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/bloc/get_kamar/get_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/bloc/get_kamar/get_kamar_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/bloc/update_kamar/update_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detail_kamar_admin_page/components/detail_kamar_admin_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detail_kamar_admin_page/components/detail_kamar_admin_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detail_kamar_admin_page/components/detail_kamar_admin_header.dart';

class DetailKamarAdminScreen extends StatefulWidget {
  final int idKamar;
  final String namaKamar;
  final String stokKamar;
  final String harga;
  final String deskripsiKamar;

  const DetailKamarAdminScreen({
    super.key,
    required this.idKamar,
    required this.namaKamar,
    required this.stokKamar,
    required this.harga,
    required this.deskripsiKamar,
  });

  @override
  State<DetailKamarAdminScreen> createState() => _DetailKamarAdminScreenState();
}

class _DetailKamarAdminScreenState extends State<DetailKamarAdminScreen> {
  late TextEditingController namaController;
  late TextEditingController stokController;
  late TextEditingController hargaController;
  late TextEditingController deskripsiController;

  final FocusNode namaFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.namaKamar);
    stokController = TextEditingController(text: widget.stokKamar);
    hargaController = TextEditingController(text: widget.harga);
    deskripsiController = TextEditingController(text: widget.deskripsiKamar);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(namaFocusNode);
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    stokController.dispose();
    hargaController.dispose();
    deskripsiController.dispose();
    namaFocusNode.dispose();
    super.dispose();
  }

  void _showDeleteConfirmation(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text(
            "Anda yakin ingin menghapus kamar ini? Tindakan ini tidak dapat dikembalikan.",
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Batal"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text("Hapus"),
              onPressed: () {
                Navigator.pop(context);
                context.read<DeleteKamarBloc>().add(
                  DeleteKamar(widget.idKamar),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _onSavePressed() {
    final request = UpdateKamarRequestModel(
      id: widget.idKamar,
      namaKamar: namaController.text.trim(),
      harga: int.parse(hargaController.text.trim()),
      stokKamar: int.parse(stokController.text.trim()),
      deskripsiKamar: deskripsiController.text.trim(),
    );
    context.read<UpdateKamarBloc>().add(SubmitUpdateKamar(request));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateKamarBloc, UpdateKamarState>(
          listener: (context, state) {
            if (state is UpdateKamarSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              context.read<GetKamarBloc>().add(GetKamarFetchEvent());
              Navigator.pop(context, true);
            } else if (state is UpdateKamarFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
        ),
        BlocListener<DeleteKamarBloc, DeleteKamarState>(
          listener: (context, state) {
            if (state is DeleteKamarSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              context.read<GetKamarBloc>().add(GetKamarFetchEvent());
              Navigator.pop(context, true);
            } else if (state is DeleteKamarFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const DetailKamarAdminHeader(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: DetailKamarAdminBody(
                  namaController: namaController,
                  stokController: stokController,
                  hargaController: hargaController,
                  deskripsiController: deskripsiController,
                  namaFocusNode: namaFocusNode,
                ),
              ),
              DetailKamarAdminFooter(
                onSavePressed: _onSavePressed,
                onDeletePressed: () => _showDeleteConfirmation(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
