import 'package:flutter/material.dart';
import 'package:story_save/ui/QuotesScreen.dart';

import 'package:story_save/ui/imageScreen.dart';
import 'package:story_save/ui/videoScreen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        ImageScreen(),
        VideoScreen(),
        QuotestextScreen()
        
      ],
    );
  }
}