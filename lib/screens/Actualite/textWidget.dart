import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


class MyTextWidget extends StatefulWidget {
  final box = GetStorage();
  final String initialText;
  final int maxLines;

  MyTextWidget({super.key, required this.initialText, required this.maxLines});

  @override
  _MyTextWidgetState createState() => _MyTextWidgetState();
}

class _MyTextWidgetState extends State<MyTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.initialText,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
