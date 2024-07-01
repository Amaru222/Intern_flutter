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
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _changePasswordBloc = ChangePasswordBloc();
  }

  @override
  void dispose() {
    _changePasswordBloc.close();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView(
              children: [
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _buildPasswordField(0, 'Mật khẩu cũ', _oldPasswordController),
                _buildPasswordField(1, 'Mật khẩu mới', _newPasswordController),
                _buildPasswordField(
                    2, 'Nhập lại mật khẩu mới', _confirmPasswordController),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _changePasswordBloc.add(ChangePasswordSubmitted(
                        _oldPasswordController.text,
                        _newPasswordController.text,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfffcd2a8),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: const Text(
                      'Đổi mật khẩu',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const CircularProgressIndicator();
                    } else if (state.error != null) {
                      return Text(state.error!);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          )),
        ));
  }

  Widget _buildPasswordField(
      int index, String hintText, TextEditingController controller) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextInputField(
            controller: controller,
            hintText: hintText,
            isObscured: state.isPasswordObscured[index],
            suffixIcon: state.isPasswordObscured[index]
                ? Icons.visibility_off
                : Icons.visibility,
            onSuffixIconPressed: () {
              _changePasswordBloc.add(TogglePasswordVisibility(index));
            },
          ),
        );
      },
    );
  }
}
