import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qr_code_generator/constants/constants.dart';

class QrCodeErrorScreen extends StatelessWidget {
  const QrCodeErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    color: lightBlue,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/error_qr_code-500x500px.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width/4,
                      height: MediaQuery.of(context).size.height/4,
                    ),
                  ),
                ),
                sizedBoxHeight50,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "qr_generation_error".tr(),
                    style: TextStyle(
                        color: connectiveBlue,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                sizedBoxHeight50,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "qr_generation_error_text1".tr(),
                          style: TextStyle(color: dynamicBlue, fontSize: 20.0),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                        sizedBoxHeight20,
                        Text(
                          "qr_generation_error_text2".tr(),
                          style: TextStyle(color: dynamicBlue, fontSize: 20.0),
                          softWrap: true,
                        ),
                        sizedBoxHeight20,
                        Text(
                          "qr_generation_error_text3".tr(),
                          style: TextStyle(
                              color: dynamicBlue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                        sizedBoxHeight5,
                        Text(
                          "qr_generation_error_text4".tr(),
                          style: TextStyle(
                              color: dynamicBlue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                        sizedBoxHeight5,
                        Text.rich(
                          TextSpan(
                            text: "qr_generation_error_text5".tr(),
                            style: TextStyle(
                                color: dynamicBlue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: "qr_generation_error_text6".tr(),
                                style: TextStyle(
                                  color: dynamicBlue,
                                  fontSize: 14.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        sizedBoxHeight20,
                        Text(
                          "qr_generation_error_text7".tr(),
                          style: TextStyle(
                            color: dynamicBlue,
                            fontSize: 20.0,
                          ),
                          softWrap: true,
                        ),
                        sizedBoxHeight20,
                        Text(
                          "qr_generation_error_text8".tr(),
                          style: TextStyle(
                            color: dynamicBlue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                        sizedBoxHeight5,
                        Text(
                          "qr_generation_error_text9".tr(),
                          style: TextStyle(
                            color: dynamicBlue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                        sizedBoxHeight20,
                        Text(
                          "qr_generation_error_text10".tr(),
                          style: TextStyle(
                            color: dynamicBlue,
                            fontSize: 20.0,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

