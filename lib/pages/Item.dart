import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ItemState();
  }
}

class ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer"),
      ),
      body: Container(
        child: Center(child: Text("Customer Page")),
      ),
    );
  }
}