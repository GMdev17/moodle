import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool isObscured;
  final TextInputType keyBoardType;
  final Widget? suffixIcon;

  const TextFormWidget({
    super.key,
    required this.controller,
    required this.text,
    this.isObscured = false,
    required this.keyBoardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
    );
  }
}
