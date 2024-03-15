import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;
  const BottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          label: "Accueil",
          icon: Icon(CupertinoIcons.square_grid_2x2),
        ),
        BottomNavigationBarItem(
          label: "Commandes",
          icon: Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          label: "Produits",
          icon: Icon(Icons.local_mall),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(CupertinoIcons.profile_circled),
        ),
      ],
    );
  }
}

class CashierBottomBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;
  const CashierBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        // BottomNavigationBarItem(
        //   label: "Dashboard",
        //   icon: Icon(Icons.shopping_cart),
        // ),
        BottomNavigationBarItem(
          label: "Mes agents",
          icon: Icon(CupertinoIcons.profile_circled),
        ),
      ],
    );
  }
}
