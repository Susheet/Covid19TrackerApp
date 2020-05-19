import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Countrydata.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/world": (BuildContext context) => Countrydata(),
        "/India": (BuildContext context) => HomePage()
      },
    );
  }
}