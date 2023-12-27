import 'package:flutter/material.dart';
class ReusableContainer extends StatelessWidget {
  const ReusableContainer({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    this.color,
    this.textColor,
    this.icon,
    this.iconColor,
  });

  final double height;
  final double width;
  final String text;
  final dynamic color;
  final dynamic textColor;
  final dynamic icon;
  final dynamic iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        height: height * 0.12,
        width: width * 0.38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}