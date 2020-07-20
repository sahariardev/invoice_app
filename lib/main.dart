import 'package:flutter/material.dart';
import 'package:invoice_generator/pages/BottomNavBar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/redux/reducers.dart';
import 'package:redux/redux.dart';

void main() {
  final _initialState = new AppState();
  final Store<AppState> _store = Store<AppState>(
      reducer, initialState: _initialState);
  runApp(MyApp(store:_store));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BottomNavBar(),
      ),
    );
  }
}


