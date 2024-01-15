import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;

  CustomFormTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: (data) {
        if (data!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(
          hintText,
          style: TextStyle(
            color: Colors.black, // Change text color to black
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),

    );
  }
}

class CustomPasswordFormTextField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final Function(String) onChanged;
  final TextEditingController controller;

  CustomPasswordFormTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.controller,
    this.obsecureText = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(
          hintText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
