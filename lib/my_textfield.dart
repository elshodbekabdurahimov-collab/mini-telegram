import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {

  final String hinText;
  final TextEditingController controller;
  final bool isObscure;
  final dynamic prefixIcon;

  const MyTextfield({
    super.key,
    required this.hinText,
    required this.controller,
    required this.isObscure,
    required this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextField(
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hinText,
            enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.white, width: 3)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color:  Colors.blue, width: 3),
            ),
            fillColor:  Colors.white,
            filled: true,
            hintStyle: TextStyle(
                color:  Colors.blue,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }
}