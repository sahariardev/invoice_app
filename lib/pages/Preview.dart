import 'package:flutter/material.dart';

class Preview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PreviewState();
  }
}

class PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Container(
        child: Center(child: Text("Preview Page")),
      ),
    );
  }
}
