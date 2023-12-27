import 'package:ascolin/utils/reusable_signup_container.dart';
import 'package:flutter/material.dart';

import '../utils/reusable_navigation_button.dart';

class TransactionSuccessful extends StatelessWidget {
  const TransactionSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Color(0xff35B369),
              ),
              height: height * 0.2,
              width: width * 0.4,
              child: Icon(
                Icons.check,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Successful Created',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Your rider is on the way to your destination',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tracking Number ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                'R-7458-4567-4434-5854',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff0560FA)),
              ),
              SizedBox(
                height: height * 0.15,
              ),
            ],
          ),
          Center(
            child: ReusableNavigationButton(
              width: width,
              height: height,
              text: 'Next',
              containerColor: Color(0xff04009A),
              textColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ReusableNavigationButton(
              width: width,
              height: height,
              text: 'Go back to Home Page',
              border: Border.all(color: Color(0xff04009A),),
              textColor: Color(0xff04009A),
            ),
          ),
        ],
      ),
    );
  }
}
