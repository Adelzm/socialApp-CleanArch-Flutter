import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  const MainTextField(
      {Key? key,
      required this.labelText,
      this.onChange,
      this.errorText,
      this.keyboardType = TextInputType.text,
      this.obscureText = false})
      : super(key: key);

  final String labelText;
  final String? errorText;
  final TextInputType keyboardType;
  final Function(String)? onChange;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
