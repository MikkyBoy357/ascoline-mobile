import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final double? width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final int? minLines;
  final int? maxLines;
  final bool obscureText;
  final bool enabled;
  final List<TextInputFormatter>? textInputFormatters;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool enableErrorMessage;
  final bool? streamText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;

  const CustomTextField(
      {Key? key,
      this.width,
      this.height = 55,
      required this.hintText,
      required this.controller,
      this.minLines = 1,
      this.maxLines = 1,
      this.obscureText = false,
      this.enabled = true,
      required this.validateFunction,
      this.onSaved,
      this.onChange,
      this.textInputType,
      this.textInputAction,
      this.focusNode,
      this.nextFocusNode,
      this.submitAction,
      this.enableErrorMessage = true,
      this.streamText,
      this.suffixIcon,
      this.prefixIcon,
      this.textInputFormatters,
      this.maxLength})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //height: widget.height,
          width: widget.width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400] ?? Colors.grey,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 10,
            ),
            child: Center(
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      textCapitalization: TextCapitalization.sentences,
                      // initialValue: widget.initialValue,
                      inputFormatters: widget.textInputFormatters,
                      enabled: widget.enabled,
                      onChanged: widget.onChange,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                      key: widget.key,
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      controller: widget.controller,
                      obscureText: widget.obscureText,
                      keyboardType: widget.textInputType,
                      validator: widget.validateFunction,
                      onSaved: (val) {
                        error = widget.validateFunction!(val)!;
                        setState(() {});
                        widget.onSaved!(val!);
                      },
                      textInputAction: widget.textInputAction,
                      focusNode: widget.focusNode,
                      // onFieldSubmitted: (String term) {
                      //   if (widget.nextFocusNode != null) {
                      //     widget.focusNode!.unfocus();
                      //     FocusScope.of(context)
                      //         .requestFocus(widget.nextFocusNode);
                      //   } else {
                      //     widget.submitAction!();
                      //   }
                      // },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: widget.height / 4,
                          bottom: widget.height / 4,
                        ),
                        isCollapsed: true,
                        isDense: true,
                        suffixIcon: widget.suffixIcon,
                        prefixIcon: widget.prefixIcon,
                        prefixIconConstraints:
                            BoxConstraints(maxHeight: widget.height / 2),
                        // prefixIcon: Icon(
                        //   widget.prefix,
                        //   size: 15.0,
                        // ),
                        // suffixIcon: InkWell(
                        //   onTap: widget.locationAction,
                        //   child: Icon(
                        //     widget.suffix,
                        //     size: 15.0,
                        //   ),
                        // ),
                        // fillColor: Colors.white,
                        filled: false,
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2A3256).withOpacity(0.5),
                        ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        // border: border(context),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
                      ),
                    ),
                    // Container(
                    //   color: Colors.blue,
                    //   height: 30,
                    //   width: 50,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // if (error != null)
        //   Container(
        //     height: 5.0,
        //   )
        // else
        //   Container(),
        // if (error != null)
        //   Text(
        //     error,
        //     style: TextStyle(
        //       color: Colors.red,
        //     ),
        //   )
        // else
        //   Container(),
      ],
    );
  }
}
