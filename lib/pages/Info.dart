import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new InfoState();
  }
}

class InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
      ),
      body: Container(
        child: Center(child: Text("Info Page")),
      ),
    );
  }
}
