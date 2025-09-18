import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';

class ButtonsTabBarWidget extends StatelessWidget {
  const ButtonsTabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      width: 160,
      height: 55,
      unselectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.transparent),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.blue),
      unselectedLabelStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
      contentCenter: true,
      tabs: [
        Tab(
          text: AppStrings.dashboard,
        ),
        Tab(
          text: AppStrings.reports,
        ),
      ],
    );
  }
}
