import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const OnboardingWidget({super.key, required this.image, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.1,
          ),
           Center(
            child: Image(
              image: AssetImage(image),
            ),
          ),
          const SizedBox( height: 48),
           Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff0560fa),
              fontSize: 24,
            ),
          ),
           const SizedBox(height: 10,),
            Text(
             text,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),



        ],
      ),
    );
  }
}
