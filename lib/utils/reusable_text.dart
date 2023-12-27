import 'package:flutter/material.dart';
class ReusableText extends StatelessWidget {
  final dynamic text;
  final dynamic color;

  const ReusableText({
    super.key,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: color,
      ),
    );
  }
}