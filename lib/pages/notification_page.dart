import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: height * 0.1,
        backgroundColor: Colors.white,
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Center(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.navigate_before,
              color: Color(0xff04009A),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          Center(
            child: Icon(
              Icons.notifications_none_sharp,
              size: 100,
              color: Colors.grey,
            ),
          ),
          Text(
            'You have no notifications',
            style: TextStyle(
              fontSize: 18,

            ),
          ),
        ],
      ),
    );
  }
}
