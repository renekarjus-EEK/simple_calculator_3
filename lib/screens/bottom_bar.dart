import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: (int index) {      //as the items are in list, we use case to select the correct one based on it's position
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/calchistory');
            break;
          case 2:
            Navigator.pushNamed(context, '/converter');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.calculate), label: 'Calculator'),
        BottomNavigationBarItem(
            icon: Icon(Icons.history), label: 'Calculator history'),
        BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows), label: 'Km <-> Miles')
      ],
    );
  }
}
