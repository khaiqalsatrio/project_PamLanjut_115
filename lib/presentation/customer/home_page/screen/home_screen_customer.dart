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

  @override
  void initState() {
    super.initState();
    context.read<GetAllHotelBloc>().add(FetchAllHotelEvent());
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    handleNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomerHeader(context),
      body: const HomeCustomerBody(),
      bottomNavigationBar: HomeCustomerFooter(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
