import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/add_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/add_kamar/add_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/get_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/get_kamar_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/get_kamar_state.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detail_kamar_admin_page/screen/detail_kamar_screen.dart';

class HomeAdminBody extends StatelessWidget {
  const HomeAdminBody({super.key});

  void _showAddKamarDialog(BuildContext context) {
    final namaController = TextEditingController();
    final stokController = TextEditingController();
    final hargaController = TextEditingController();
    final deskripsiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Tambah Kamar'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama Kamar'),
                ),
                TextField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Stok Kamar'),
                ),
                TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Harga'),
                ),
                TextField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final request = AddKamarRequestModel(
                  namaKamar: namaController.text,
                  stokKamar: int.tryParse(stokController.text) ?? 0,
                  harga: int.tryParse(hargaController.text) ?? 0,
                  deskripsiKamar: deskripsiController.text,
                );
                context.read<AddKamarBloc>().add(SubmitAddKamar(request));
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddKamarBloc, AddKamarState>(
      listener: (context, state) {
        if (state is AddKamarSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kamar berhasil ditambahkan!')),
          );
          context.read<GetKamarBloc>().add(GetKamarFetchEvent());
        } else if (state is AddKamarFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
        }
      },
      child: BlocBuilder<GetKamarBloc, GetKamarState>(
        builder: (context, state) {
          Widget content;

          if (state is GetKamarLoading) {
            content = const Center(child: CircularProgressIndicator());
          } else if (state is GetKamarSuccess) {
            final kamarList = state.kamar;

            if (kamarList.isEmpty) {
              content = Center(
                child: Text(
                  "Tidak ada data kamar tersedia\ntambahkan data kamar anda sekarang.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              );
            } else {
              content = ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: kamarList.length,
                itemBuilder: (context, index) {
                  final kamar = kamarList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => DetailKamarAdminScreen(
                                idKamar: kamar.id,
                                namaKamar: kamar.namaKamar,
                                stokKamar: kamar.stokKamar.toString(),
                                harga: kamar.harga.toString(),
                                deskripsiKamar: kamar.deskripsiKamar,
                              ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: const Color(0xFF8BA2E7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.king_bed_outlined,
                                color: Color(0xFF8BA2E7),
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kamar.namaKamar,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    kamar.deskripsiKamar,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.storage,
                                        color: Colors.teal.shade600,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text('Stok: ${kamar.stokKamar}'),
                                      const SizedBox(width: 16),
                                      const Icon(
                                        Icons.attach_money,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Rp ${kamar.harga}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is GetKamarFailure) {
            content = Center(child: Text('Error: ${state.message}'));
          } else {
            content = const SizedBox.shrink();
          }

          return Scaffold(
            body: content,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddKamarDialog(context),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
