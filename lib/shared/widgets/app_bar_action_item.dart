import 'package:flutter/material.dart';
import 'package:qr_code_generator/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarActionItem extends StatefulWidget {
  const AppBarActionItem({
    super.key,
    required this.padding,
    required this.itemString,
    required this.listIndex,
    required this.url,
    required this.appBarActionList,
  });

  final double padding;
  final String itemString;
  final int listIndex;
  final String url;
  final List appBarActionList;

  @override
  State<AppBarActionItem> createState() => _AppBarActionItemState();
}

class _AppBarActionItemState extends State<AppBarActionItem> {

  Future<void> launchUrlFunction(Uri url) async {
    if (!await launchUrl(
      url,
    )) {
      debugPrint("Could not launch: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: widget.padding, bottom: 20.0),
      child: InkWell(
        child: Text(
          widget.itemString,
          style: TextStyle(
              color: widget.appBarActionList[widget.listIndex] ? textGrey : unitingWhite,
              fontSize: 15.0),
        ),
        onHover: (value) {
          setState(() {
            widget.appBarActionList[widget.listIndex] = value;
          });
        },
        onTap: () async {
          await launchUrlFunction(Uri.parse(widget.url));
        },
      ),
    );
  }
}
