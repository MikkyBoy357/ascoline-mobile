import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/reusable_signup_container.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.back),
        title: Text('Profile'),
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 50),
              PaymentOptionCard(
                title: "Pay with wallet",
                subtitle: "complete the payment using your e wallet",
              ),
              PaymentOptionCard(
                title: "Credit / debit card",
                subtitle: "add new card",
              ),
              PaymentOptionCard(
                title: "**** **** 3323",
                subtitle: "remove card",
              ),
              SizedBox(height: 50),
              ReusableSignUpContainer(
                text: 'Proceed to pay',
                margin: EdgeInsets.only(bottom: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  final String title;
  final String? subtitle;

  const PaymentOptionCard({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      elevation: 3,
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 9,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 6,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Visibility(
                      visible: subtitle != null,
                      child: Container(
                        width: size.width / 1.5,
                        child: Text(
                          "${subtitle}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500]!,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
