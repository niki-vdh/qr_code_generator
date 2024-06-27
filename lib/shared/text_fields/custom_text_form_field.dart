import 'package:flutter/material.dart';
import 'package:qr_code_generator/constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, required this.labelText, required this.controller});

  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: dynamicBlue,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 600,
          child: TextFormField(
            style: TextStyle(color: dynamicBlue),
            controller: controller,
            decoration: InputDecoration(
              // labelText: "joint_committee".tr(),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: connectiveBlue, // Border color
                  width: 0.5, // Border width
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: connectiveBlue,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: connectiveBlue,
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
