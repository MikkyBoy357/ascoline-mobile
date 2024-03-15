import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
