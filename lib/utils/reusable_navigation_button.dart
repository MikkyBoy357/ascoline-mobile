import 'package:flutter/material.dart';
class ReusableNavigationButton extends StatelessWidget {
  const ReusableNavigationButton({
    super.key,
    required this.width,

    required this.height, this.onTap,this.border, required this.text, this.textColor, this.containerColor,
  });

  final double width;
  final String text;
  final double height;
  final dynamic onTap;
  final dynamic textColor;
  final dynamic containerColor;
  final dynamic border;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.9,
        height: height * 0.07,
        decoration: BoxDecoration(
          color: containerColor,
          border: border,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}