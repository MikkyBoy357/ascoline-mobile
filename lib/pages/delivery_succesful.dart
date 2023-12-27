import 'package:ascolin/utils/reusable_signup_container.dart';
import 'package:flutter/material.dart';

import '../utils/reusable_navigation_button.dart';
import '../utils/star_row.dart';

class DeliverySuccessful extends StatefulWidget {
  const DeliverySuccessful({super.key});

  @override
  State<DeliverySuccessful> createState() => _DeliverySuccessfulState();
}

class _DeliverySuccessfulState extends State<DeliverySuccessful> {
  bool isTapped = false;

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
            'Delivery Successful',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Your Item has been delivered successfully',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Rate Rider',
            style: TextStyle(color: Color(0xff04009A), fontSize: 16),
          ),
          StarRow(),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 70,
            width: width * 0.95,
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.message,
                    color: Color(0xff04009A),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Add feedback',
                    style: TextStyle(
                      color: Color(0xffA7A7A7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
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
        ],
      ),
    );
  }
}

