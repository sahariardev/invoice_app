import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:invoice_generator/util/constants.dart';

import 'Info.dart';
import 'ItemPage.dart';
import 'Preview.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final Info infoPage = new Info();
  final ItemPage itemPage = new ItemPage();
  Preview previewPage = new Preview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.info_outline, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.insert_drive_file, size: 30),
          ],
          color: PRIMARY_COLOR,
          buttonBackgroundColor: BACKGROUND_COLOR,
          backgroundColor: BACKGROUND_COLOR,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Container(
          color: Colors.white,
          child: pageProvider(_page),
        ));
  }

  Widget pageProvider(page) {
    if (page == 0) {
      return infoPage;
    } else if (page == 1) {
      return itemPage;
    } else if (page == 2) {
      return previewPage;
    }
    return infoPage;
  }
}
