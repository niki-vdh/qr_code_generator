import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/constants/constants.dart';

class VatTextFormField extends StatelessWidget {
  const VatTextFormField({
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
    final formKey = GlobalKey<FormState>();

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
            key: formKey,
            validator: (value){
              if(value?.length != 10){
                return "invalid_vat_number".tr();
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(color: dynamicBlue),
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BE", style: TextStyle(fontSize: 20.0, color: connectiveBlue),),
                ],
              ),
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
