import 'package:flutter/material.dart';
import 'package:news_app_assignment6/constants/colors.dart';

class AppBarIcons extends StatelessWidget {
  const AppBarIcons(this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: appBarIconColor,
        size: 30,
      ),
      onPressed: null,
    );
  }
}
