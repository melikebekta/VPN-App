import 'package:flutter/material.dart';
import 'package:vpn_app/Utils/Colors.dart';

class Bottomnavigationbar extends StatelessWidget {
  const Bottomnavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: SpecialColors.mainColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Countries',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icon/wifi.png', width: 24, height: 24),
          label: 'Disconnect',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icon/setting.png', width: 24, height: 24),
          label: 'Setting',
        ),
      ],
    );
  }
}
