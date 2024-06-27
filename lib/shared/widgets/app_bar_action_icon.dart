import 'package:flutter/material.dart';
import 'package:qr_code_generator/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarActionIcon extends StatefulWidget {
  const AppBarActionIcon({
    super.key,
    required this.listIndex,
    required this.url,
    required this.appBarActionIconList,
  });

  final int listIndex;
  final String url;
  final List appBarActionIconList;

  @override
  State<AppBarActionIcon> createState() => _AppBarActionIconState();
}

class _AppBarActionIconState extends State<AppBarActionIcon> {

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
      // padding: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(left: 10.0, right: 30.0),
      child: InkWell(
        child: Icon(
          Icons.people_alt_rounded,
          color: widget.appBarActionIconList[widget.listIndex] ? textGrey : unitingWhite,
        ),
        // child: Column(
        //   children: [
        //     Icon(
        //       Icons.people_alt_rounded,
        //       color: widget.appBarActionIconList[widget.listIndex] ? textGrey : unitingWhite,
        //     ),
        //     Text(
        //       "CONNECT",
        //       style: TextStyle(
        //           color:
        //               widget.appBarActionIconList[widget.listIndex] ? textGrey : unitingWhite,
        //           fontSize: 15.0),
        //     ),
        //   ],
        // ),
        onHover: (value) {
          setState(() {
            widget.appBarActionIconList[widget.listIndex] = value;
          });
        },
        onTap: () async {
          await launchUrlFunction(Uri.parse(widget.url));
        },
      ),
    );
  }
}
