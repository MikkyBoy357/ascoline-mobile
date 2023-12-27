import 'package:flutter/material.dart';
class ReusableSmallContainer extends StatelessWidget {
  const ReusableSmallContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff0560fa),
      ),
      height: height * 0.055,
      width: width * 0.22,
      child: const Center(
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}