import 'package:flutter/cupertino.dart';

import '../base/validation.dart';
import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    this.hintText = 'Au moins 8 characteres',
    this.title = 'Mot de passe',
    this.textInputType = TextInputType.number,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String title;
  final TextInputType textInputType;
  final void Function(String)? onChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: Color(0xffA7A7A7),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Stack(
          children: [
            CustomTextField(
              hintText: widget.hintText,
              controller: widget.controller,
              obscureText: isObscure,
              enabled: true,
              validateFunction: Validations.validatePassword,
              textInputType: widget.textInputType,
              onChange: widget.onChanged,
              // textInputFormatters: [
              //   LengthLimitingTextInputFormatter(
              //     8,
              //   ), //6 is maximum number of characters you want in textfield
              // ],
            ),
            Positioned(
              right: 15,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                child: Icon(CupertinoIcons.eye_slash),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
