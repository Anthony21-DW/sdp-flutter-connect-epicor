import 'package:flutter/material.dart';
import 'package:flutter_fix_sdp/views/epicor_view.dart';
import 'package:flutter_fix_sdp/views/home_view.dart';
import 'package:flutter_fix_sdp/views/login_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Sdp',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[300]),
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
