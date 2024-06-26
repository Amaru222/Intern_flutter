import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/auth/changePassword/bloc/change_password_bloc.dart';
import 'package:project/features/auth/component/text_input_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late ChangePasswordBloc _changePasswordBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _changePasswordBloc = ChangePasswordBloc();
  }

  @override
  void dispose() {
    _changePasswordBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _changePasswordBloc,
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
                  const Text('Đổi mật khẩu'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextInputField(
                              controller: _passwordController,
                              hintText: 'Mật khẩu',
                              onSuffixIconPressed: () {},
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
