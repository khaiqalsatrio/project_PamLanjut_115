import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/get_all_hotel/bloc/get_all_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/components/home_customer_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/components/home_customer_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/components/home_customer_header.dart';

class HomeScreenCustomer extends StatefulWidget {
  const HomeScreenCustomer({super.key});

  @override
  State<HomeScreenCustomer> createState() => _HomeScreenCustomerState();
}

class _HomeScreenCustomerState extends State<HomeScreenCustomer> {
  int _currentIndex = 0;
  late TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<GetAllHotelBloc>().add(FetchAllHotelEvent());
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        context.read<GetAllHotelBloc>().add(FetchAllHotelEvent());
      } else {
        context.read<GetAllHotelBloc>().add(SearchHotelByKotaEvent(query));
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    handleNavigation(context, index); // fungsi navigasi jika ada
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: HomeCustomerHeader(
          context,
          controller: _searchController,
          onChanged: _onSearchChanged,
        ),
      ),
      body: const HomeCustomerBody(),
      bottomNavigationBar: HomeCustomerFooter(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
