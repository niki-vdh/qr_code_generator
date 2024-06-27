import 'package:flutter/material.dart';
import 'package:qr_code_generator/constants/constants.dart';

class CustomLongTextTextFormField extends StatelessWidget {
  const CustomLongTextTextFormField({
    super.key,
    required this.labelText1,
    required this.labelText2,
    required this.controller,
  });

  final String labelText1;
  final String labelText2;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: labelText1,
                style: TextStyle(
                  color: dynamicBlue,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " $labelText2",
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 16.0,
                  ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 600,
          child: TextFormField(
            style: TextStyle(color: dynamicBlue),
            controller: controller,
            decoration: InputDecoration(
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
