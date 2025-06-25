import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/core/core.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/auth/register_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/login_page/screen/login_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/register_page/bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController namaController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    namaController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    namaController.dispose();
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
                Icon(
                  Icons.person_add_alt_1,
                  size: 64,
                  color: AppColors.primary,
                ),
                const SpaceHeight(16),
                Text(
                  "DAFTAR AKUN INAP GO",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SpaceHeight(40),

                // Form dalam Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        validator: 'Nama tidak boleh kosong',
                        controller: namaController,
                        label: 'Nama Lengkap',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: AppColors.primary,
                        ),
                      ),
                      const SpaceHeight(20),
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
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            // Tampilkan snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: AppColors.primary,
                              ),
                            );

                            // Tunggu sebentar lalu redirect ke login
                            Future.delayed(const Duration(seconds: 2), () {
                              // ignore: use_build_context_synchronously
                              context.pushAndRemoveUntil(
                                const LoginScreen(),
                                (route) => false,
                              );
                            });
                          } else if (state is RegisterFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  34,
                                  35,
                                  35,
                                ),
                              ),
                            );
                          }
                        },

                        builder: (context, state) {
                          return Button.filled(
                            onPressed:
                                state is RegisterLoading
                                    ? null
                                    : () {
                                      if (_key.currentState!.validate()) {
                                        final request = RegisterRequestModel(
                                          nama: namaController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                        context.read<RegisterBloc>().add(
                                          RegisterRequested(
                                            requestModel: request,
                                          ),
                                        );
                                      }
                                    },
                            label:
                                state is RegisterLoading
                                    ? 'Memuat...'
                                    : 'Daftar',
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SpaceHeight(20),

                // Navigasi ke login
                Text.rich(
                  TextSpan(
                    text: 'Sudah punya akun? ',
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Login disini',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                context.push(const LoginScreen());
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
