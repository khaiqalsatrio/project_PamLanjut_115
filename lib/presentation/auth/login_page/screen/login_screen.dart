import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/core/core.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/auth/login_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/screen/add_hotel_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/screen/home_screen_admin.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/login_page/bloc/login_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/register_page/screen/register_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/screen/home_screen_customer.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>(); // Inisiasi key
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueLight,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hotel, size: 64, color: AppColors.primary),
                const SpaceHeight(16),
                Text(
                  "INAP GO",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                const SpaceHeight(40),
                // Form Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        validator: 'Email tidak boleh kosong',
                        controller: emailController,
                        label: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      const SpaceHeight(20),
                      CustomTextField(
                        validator: 'Password tidak boleh kosong',
                        controller: passwordController,
                        label: 'Password',
                        obscureText: !isShowPassword,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.primary,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                          icon: Icon(
                            isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      const SpaceHeight(30),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) async {
                          if (state is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          } else if (state is LoginSuccess) {
                            final role =
                                state.responseModel.user?.role?.toLowerCase();
                            if (role == 'admin') {
                              final adminRepository =
                                  context.read<AdminRepository>();
                              final hasHotel =
                                  await adminRepository.checkIfAdminHasHotel();
                              if (hasHotel) {
                                // ignore: use_build_context_synchronously
                                context.pushAndRemoveUntil(
                                  const HomeScreenAdmin(),
                                  (route) => false,
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                context.pushAndRemoveUntil(
                                  const AddHotelScreen(),
                                  (route) => false,
                                );
                              }
                            } else if (role == 'customer') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    state.responseModel.message ??
                                        'Berhasil masuk!',
                                  ),
                                ),
                              );
                              context.pushAndRemoveUntil(
                                const HomeScreenCustomer(),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Role tidak dikenali'),
                                ),
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return Button.filled(
                            onPressed:
                                state is LoginLoading
                                    ? null
                                    : () {
                                      if (_key.currentState!.validate()) {
                                        final request = LoginRequestModel(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                        context.read<LoginBloc>().add(
                                          LoginRequested(requestModel: request),
                                        );
                                      }
                                    },
                            label:
                                state is LoginLoading ? 'Memuat...' : 'Masuk',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SpaceHeight(20),
                // Navigasi ke Register
                Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Daftar disini',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                context.push(const RegisterScreen());
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
