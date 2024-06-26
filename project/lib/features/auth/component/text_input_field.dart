import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscured;
  final VoidCallback? onSuffixIconPressed;
  final IconData? suffixIcon;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isObscured = false,
    this.onSuffixIconPressed,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.1,
      child: TextFormField(
        controller: controller,
        obscureText: isObscured,
        style: const TextStyle(
          color: Color(0xfff2b87d),
          fontSize: 20,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffffdbd2),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xfff2b87d)),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onSuffixIconPressed,
                  icon: Icon(suffixIcon),
                )
              : null,
        ),
      ),
    );
  }
}
