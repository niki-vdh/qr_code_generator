import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qr_code_generator/constants/constants.dart';
import 'package:qr_code_generator/screens/qr_code_error_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../text_fields/custom_long_text_text_form_field.dart';
import '../../text_fields/custom_text_form_field.dart';
import '../../text_fields/vat_text_form_field.dart';
import '../../widgets/app_bar_action_icon.dart';
import '../../widgets/app_bar_action_item.dart';

class NormalHeightLayout extends StatefulWidget {
  const NormalHeightLayout({super.key});

  @override
  State<NormalHeightLayout> createState() => _NormalHeightLayoutState();
}

class _NormalHeightLayoutState extends State<NormalHeightLayout> {
  final _jointCommitteeController = TextEditingController();
  final _familyNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _inssController = TextEditingController();
  final _vatController = TextEditingController();
  final _companyController = TextEditingController();
  List bottomPrivacyTapList = [false, false, false];
  List changeLanguageList = [false, false, false];
  List appBarActionList = [false, false];
  List appBarActionIconList = [false];

  String formatInss(String inss) {
    String part1 = inss.substring(0, 2);
    String part2 = inss.substring(2, 4);
    String part3 = inss.substring(4, 6);
    String part4 = inss.substring(6, 9);
    String part5 = inss.substring(9, 11);
    String result = "$part1.$part2.$part3-$part4-$part5";
    return result;
  }

  String formatVat(String vat) {
    String part1 = vat.substring(0, 4);
    String part2 = vat.substring(4, 7);
    String part3 = vat.substring(7, 10);
    String result = "$part1.$part2.$part3";
    return result;
  }

  String generateQrData() {
    final inssFormatted = formatInss(_inssController.text);
    final vatFormatted = formatVat(_vatController.text);
    return "${_jointCommitteeController.text}|${_nameController.text}|${_familyNameController.text}|$inssFormatted|$vatFormatted";
  }

  downloadQrCode() async {
    String qrData = "";
    if (_jointCommitteeController.text.isNotEmpty &&
        _familyNameController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _inssController.text.isNotEmpty &&
        _vatController.text.isNotEmpty &&
        _companyController.text.isNotEmpty) {
      qrData = generateQrData();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.redAccent,
                size: 30.0,
              ),
            ),
            content: Text(
              "complete_textfields".tr(),
              style: TextStyle(color: dynamicBlue, fontSize: 18.0),
              softWrap: true,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: connectiveBlue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
    }
    if (qrData.isNotEmpty || qrData != "") {
      final qrValidationResult = QrValidator.validate(
        data: qrData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      if (qrValidationResult.isValid) {
        final QrCode? qrCode = qrValidationResult.qrCode;
        final QrPainter qrPainter = QrPainter.withQr(
          qr: qrCode!,
          eyeStyle: const QrEyeStyle(color: Colors.white),
          dataModuleStyle: const QrDataModuleStyle(color: Colors.white),
        );
        final ui.Picture picture = qrPainter.toPicture(300);
        final ui.Image image = await picture.toImage(300, 300);
        final ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);

        final buffer = Uint8List.sublistView(byteData!.buffer.asUint8List());

        final blob = html.Blob([buffer]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download = 'qrcode.png';
        html.document.body!.append(anchor);
        anchor.click();
        html.Url.revokeObjectUrl(url);
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QrCodeErrorScreen()));
      }
    } else {
      return;
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const QrCodeErrorScreen()));
    }
  }

  Future<void> launchUrlFunction(Uri url) async {
    if (!await launchUrl(
      url,
    )) {
      debugPrint("Could not launch: $url");
    }
  }

  bottomPrivacyItem(String itemString, listIndex, String url) {
    return InkWell(
      child: Text(
        itemString,
        style: TextStyle(
          color: bottomPrivacyTapList[listIndex] ? textGrey : unitingWhite,
          fontSize: 15.0,
        ),
      ),
      onHover: (value) {
        setState(() {
          bottomPrivacyTapList[listIndex] = value;
        });
      },
      onTap: () async {
        await launchUrlFunction(Uri.parse(url));
      },
    );
  }

  languageItem(double padding, String languageString, int listIndex,
      String languageCode, String countryCode, List changeLanguageList) {
    return Padding(
      padding: EdgeInsets.only(right: padding),
      child: InkWell(
        child: Text(
          languageString,
          style: TextStyle(
              color: changeLanguageList[listIndex] ? textGrey : unitingWhite,
              fontSize: 15.0),
        ),
        onHover: (value) {
          setState(() {
            changeLanguageList[listIndex] = value;
          });
        },
        onTap: () {
          setState(() {
            context.setLocale(Locale(languageCode, countryCode));
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: dynamicBlue,
        scrolledUnderElevation: 4.0,
        toolbarHeight: MediaQuery.of(context).size.height / 8.0,
        // toolbarHeight: MediaQuery.of(context).size.height / 5.0,
        title: Transform.scale(
          scale: 0.7,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                "assets/images/allConnects_logo.png",
                fit: BoxFit.contain,
              ),
            ),
            onTap: () async {
              await launchUrlFunction(
                  Uri.parse("https://tools.all-connects.be/"));
            },
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBarActionItem(
                padding: 10.0,
                itemString: "toolbox_overview".tr(),
                listIndex: 0,
                url: "https://tools.all-connects.be/",
                appBarActionList: appBarActionList,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  height: 10,
                  width: 1.2,
                  decoration: BoxDecoration(
                    color: connectiveBlue,
                  ),
                ),
              ),
              sizedBoxWidth10,
              AppBarActionItem(
                padding: 30.0,
                itemString: "go_to_ac_website".tr(),
                listIndex: 1,
                url: "https://en.all-connects.be/en/home",
                appBarActionList: appBarActionList,
              ),
            ],
          ),
        ),
        actions: [
          languageItem(10.0, "NL", 0, "nl", "BE", changeLanguageList),
          languageItem(10.0, "FR", 1, "fr", "FR", changeLanguageList),
          languageItem(30.0, "EN", 2, "en", "US", changeLanguageList),
          AppBarActionIcon(
            listIndex: 0,
            url: "https://live.connects.eu/ui/login/",
            appBarActionIconList: appBarActionIconList,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/banner_achtergrond2.png",
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 100.0, right: 200.0),
                                child: Text(
                                  "QR-Code Generator",
                                  style: TextStyle(
                                      color: unitingWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              sizedBoxHeight20,
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 120.0, right: 200.0),
                                child: Text(
                                  "qr_generator_title_text".tr(),
                                  style: TextStyle(
                                      color: unitingWhite, fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 80.0),
                          child: Transform.scale(
                            scale: 1.5,
                            child: Image.asset(
                              "assets/images/allConnects_icon_white.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight50,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "qr_generator_body_part1_title".tr(),
                  style: TextStyle(
                    color: dynamicBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                sizedBoxHeight5,
                Text(
                  "qr_generator_body_part1_text1".tr(),
                  style: TextStyle(
                    color: dynamicBlue,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "qr_generator_body_part1_text2".tr(),
                  style: TextStyle(
                    color: dynamicBlue,
                    fontSize: 18.0,
                  ),
                ),
                sizedBoxHeight20,
                Text(
                  "qr_generator_body_part2_title".tr(),
                  style: TextStyle(
                    color: dynamicBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                sizedBoxHeight5,
                Text(
                  "qr_generator_body_part2_text1".tr(),
                  style: TextStyle(
                    color: dynamicBlue,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "qr_generator_body_part2_text2".tr(),
                  style: TextStyle(
                    color: dynamicBlue,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "qr_generator_body_part2_text3".tr(),
                  style: TextStyle(
                    color: dynamicBlue,
                    fontSize: 18.0,
                  ),
                ),
                sizedBoxHeight50,
                Column(
                  children: [
                    CustomLongTextTextFormField(
                      labelText1: "joint_committee".tr(),
                      labelText2: "joint_committee_text".tr(),
                      controller: _jointCommitteeController,
                    ),
                    sizedBoxHeight20,
                    CustomTextFormField(
                      labelText: "family_name".tr(),
                      controller: _familyNameController,
                    ),
                    sizedBoxHeight20,
                    CustomTextFormField(
                      labelText: "first_name".tr(),
                      controller: _nameController,
                    ),
                    sizedBoxHeight20,
                    CustomLongTextTextFormField(
                      labelText1: "inss_number".tr(),
                      labelText2: "inss_number_text".tr(),
                      controller: _inssController,
                    ),
                    sizedBoxHeight20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        VatTextFormField(
                          labelText1: "vat_number".tr(),
                          labelText2: "vat_number_text".tr(),
                          controller: _vatController,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "vat_number_search_1".tr(),
                              style: TextStyle(color: textGrey, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "vat_number_search_2".tr(),
                                    style: TextStyle(
                                        color: textGrey,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launchUrlFunction(Uri.parse(
                                            "https://www.btw-opzoeken.be/"));
                                      })
                              ]),
                        ),
                      ],
                    ),
                    sizedBoxHeight20,
                    CustomTextFormField(
                      labelText: "company".tr(),
                      controller: _companyController,
                    ),
                    sizedBoxHeight50,
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(300, 70),
                        foregroundColor: unitingWhite,
                        backgroundColor: connectiveBlue,
                      ),
                      onPressed: downloadQrCode,
                      child: Text(
                        "create_qr_code".tr(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: unitingWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            sizedBoxHeight50,
            Container(
              color: dynamicBlue,
              height: MediaQuery.of(context).size.height / 10,
              // width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Center(
                  child: Wrap(
                    children: [
                      Icon(
                        Icons.copyright_rounded,
                        color: unitingWhite,
                        size: 15.0,
                      ),
                      sizedBoxWidth10,
                      Text(
                        "2024 ALLCONNECTS      ",
                        style: TextStyle(
                          color: unitingWhite,
                          fontSize: 15.0,
                        ),
                      ),
                      bottomPrivacyItem(
                        "General Terms and Conditions      ",
                        0,
                        "https://en.all-connects.be/en/general-terms-and-conditions",
                      ),
                      bottomPrivacyItem(
                        "Privacy      ",
                        1,
                        "https://en.all-connects.be/en/privacy-policy",
                      ),
                      bottomPrivacyItem(
                        "Cookie Policy",
                        2,
                        "https://en.all-connects.be/en/cookie-policy",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
