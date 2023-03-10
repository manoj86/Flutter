import 'package:flutter/material.dart';
import 'package:navigator/location_builder.dart';
import 'compass_builder.dart';

//Home Screen
class NavigatorHome extends StatelessWidget {
  const NavigatorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text("Navigator"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(height: 40),
            LocationBuilder(),
            SizedBox(height: 20),
            CompassBuilder()
          ],
        ),
      ),
    );
  }
}
