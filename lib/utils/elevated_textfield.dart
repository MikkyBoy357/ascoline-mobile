import 'package:flutter/material.dart';
class ElevatedTextField extends StatelessWidget {
  final String text;

  const ElevatedTextField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Material(
        elevation: 8,
        child: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 4, left: 10),
                hintText: text,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
          ),
        ),
      ),
    );
  }
}
