import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final keyboardType;
  final Widget? suffixIcons;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.keyboardType,
    this.suffixIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: TextField(
        textInputAction: TextInputAction.next,
        enableInteractiveSelection: true,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        keyboardAppearance: Brightness.dark,
        decoration: InputDecoration(
            suffixIcon: suffixIcons,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Color.fromARGB(255, 68, 67, 67)),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
        inputFormatters: keyboardType == TextInputType.emailAddress
            ? [LowerCaseEmailTextFormatter()]
            : null,
      ),
    );
  }
}

class LowerCaseEmailTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      return TextEditingValue(
        text: newValue.text.toLowerCase(),
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}
