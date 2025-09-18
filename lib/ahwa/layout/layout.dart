import 'package:ahwa/ahwa/layout/widget/floating_button.dart';
import 'package:flutter/material.dart';

import '../dashboard/dashboard_tab_screen.dart';
import '../reports/reports_tab_screen.dart';
import 'widget/buttons_tab_bar_widget.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Screen'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
          child: FloatingWidget(
            mainScreenWidget: Column(
              children: [
                ButtonsTabBarWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TabBarView(
                      children: [
                        DashboardTabScreen(),
                        ReportsTabScreen(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
