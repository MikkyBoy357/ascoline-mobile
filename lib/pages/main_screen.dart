import 'package:ascolin/pages/home_page.dart';
import 'package:ascolin/pages/order_list_screen.dart';
import 'package:ascolin/pages/product_list_screen.dart';
import 'package:ascolin/pages/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_bar.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  var cartItemId;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem = 0;
  late String uid;
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
        controller: _pageController,
        children: [
          HomePage(),
          OrderListScreen(),
          ProductListScreen(),
          // Center(child: Text('Track')),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _selectedItem,
        onTap: (index) {
          setState(
            () {
              _selectedItem = index;
              _pageController.animateToPage(_selectedItem,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
          );
        },
      ),
    );
  }
}
