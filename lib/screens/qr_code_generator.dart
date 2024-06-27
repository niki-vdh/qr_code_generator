import 'package:flutter/material.dart';

import '../shared/layout/qr_code_generator/normal_height_layout.dart';
import '../shared/layout/qr_code_generator/small_height_layout.dart';
import '../shared/layout/qr_code_generator/small_width_layout.dart';

class QrCodeGenerator extends StatelessWidget {
  const QrCodeGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 900.0) {
      return const SmallWidthLayout();
    } else if (MediaQuery.of(context).size.height < 800.0) {
      return const SmallHeightLayout();
    } else {
      return const NormalHeightLayout();
    }
  }
}
