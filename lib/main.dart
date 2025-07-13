import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/auth_repository.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/add_kamar/add_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/get_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detail_kamar_admin_page/bloc/delete_kamar/delete_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detail_kamar_admin_page/bloc/update_kamar/update_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/bloc/get_hotel/get_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/bloc/get_booking_by_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/bloc/detail_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/login_page/bloc/login_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/login_page/screen/login_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/register_page/bloc/register_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/register_page/screen/register_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/booking_page/bloc/booking_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/bloc/booking_detail_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/bloc/detail_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/get_all_hotel/bloc/get_all_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/screen/home_screen_customer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/bloc/get_riwayat_booking_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/service/service_http_client.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final serviceClient = ServiceHttpClient();
    final authRepository = AuthRepository(serviceClient);
    final customerRepository = CustomerRepository(serviceClient);
    final adminRepository = AdminRepository(serviceClient);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => authRepository),
        RepositoryProvider<CustomerRepository>(
          create: (_) => customerRepository,
        ),
        RepositoryProvider<AdminRepository>(create: (_) => adminRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LoginBloc(authRepository: authRepository),
          ),
          BlocProvider(
            create: (_) => RegisterBloc(authRepository: authRepository),
          ),
          BlocProvider(create: (_) => GetAllHotelBloc(customerRepository)),
          BlocProvider(create: (_) => DetailKamarBloc(customerRepository)),
          BlocProvider(create: (_) => BookingDetailBloc(customerRepository)),
          BlocProvider(create: (_) => BookingKamarBloc(customerRepository)),
          BlocProvider(create: (_) => GetProfileBloc(authRepository)),
          BlocProvider(create: (_) => GetHotelBloc(adminRepository)),
          BlocProvider(create: (_) => GetKamarBloc(adminRepository)),
          BlocProvider(create: (_) => AddKamarBloc(adminRepository)),
          BlocProvider(create: (_) => UpdateKamarBloc(adminRepository)),
          BlocProvider(create: (_) => DeleteKamarBloc(adminRepository)),
          BlocProvider(create: (_) => AddHotelBloc(adminRepository)),
          BlocProvider(create: (_) => GetBookingByHotelBloc(adminRepository)),
          BlocProvider(create: (_) => DetailHotelBloc(adminRepository)),
          BlocProvider(
            create: (_) => GetRiwayatBookingBloc(customerRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Inap Go',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreenCustomer(),
          },
        ),
      ),
    );
  }
}
