import 'package:flutter/material.dart';

class Customer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CustomerState();
  }
}

class CustomerState extends State<Customer> {
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