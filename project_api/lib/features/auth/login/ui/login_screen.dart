import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/auth/component/text_input_field.dart';
import 'package:project/features/auth/login/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(dio: Dio());
  }

  @override
  void dispose() {
    _loginBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width + 0.8,
              decoration: const BoxDecoration(color: Colors.white),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png'),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: TextInputField(
                          controller: _emailController,
                          hintText: 'Nhập email hoặc số điện thoại',
                        ),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextInputField(
                              controller: _passwordController,
                              hintText: 'Mật khẩu',
                              isObscured: state.isPasswordObscured,
                              suffixIcon: state.isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              onSuffixIconPressed: () {
                                context
                                    .read<LoginBloc>()
                                    .add(TogglePasswordVisibility());
                              },
                            ),
                          );
                        },
                      ),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state.status == LoginStatus.success) {
                            context.go('/');
                          } else if (state.status == LoginStatus.failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Sai tên đăng nhập hoặc mật khẩu'),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: state.status == LoginStatus.loading
                                    ? null
                                    : () {
                                        context.read<LoginBloc>().add(
                                            LoginRequest(
                                                username: _emailController.text,
                                                password:
                                                    _passwordController.text));
                                      },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xfffcd2a8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                child: state.status == LoginStatus.loading
                                    ? const CircularProgressIndicator()
                                    : const Text('ĐĂNG NHẬP',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Quên mật khẩu',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
