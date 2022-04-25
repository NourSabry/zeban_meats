import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final String value;
  TextWidget({this.value, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value == null ? " " : "$value",
              style: TextStyle(
                  color: Color(0xFF8d2424),
                  fontSize: 20.0,
                  fontFamily: "lateef",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 20.0),
            Text(
              ":$title",
              style: TextStyle(
                color: Color(0xFFca4153),
                fontSize: 16.0,
                fontFamily: "amiri",
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ]),
    );
  }
}
