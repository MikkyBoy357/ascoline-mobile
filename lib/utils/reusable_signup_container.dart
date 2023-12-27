import 'package:flutter/material.dart';

class ReusableSignUpContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;

  const ReusableSignUpContainer({
    super.key,
    this.onTap,
    required this.text,
    this.backgroundColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor ?? Color(0xff04009A),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 52,
        width: size.width - 40,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
