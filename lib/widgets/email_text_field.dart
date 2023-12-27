import 'package:flutter/material.dart';

import '../base/validation.dart';
import 'custom_text_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.controller,
    this.title = 'Addresse Email',
    this.hintText = 'myemail@gmail.com',
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xffA7A7A7),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          validateFunction: Validations.validateEmail,
          textInputType: TextInputType.emailAddress,
          onChange: onChanged,
        ),
      ],
    );
  }
}
