import 'package:flutter/material.dart';
import 'package:reactive_movie_app/ui/my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.grey[850], canvasColor: Colors.grey[850]),
      home: MyHomePage(),
    );
  }
}

