import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final dynamic text;
  final dynamic hintText;

  const ReusableTextField({
    super.key,
    required this.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xffA7A7A7),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                color: Color(0xffCFCFCF),
                fontWeight: FontWeight.w500,
              ),
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
