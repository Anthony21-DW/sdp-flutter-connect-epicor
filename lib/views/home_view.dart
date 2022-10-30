import 'package:flutter/material.dart';
import 'package:flutter_fix_sdp/controller/login_controller.dart';
import 'package:flutter_fix_sdp/views/epicor_view.dart';
import 'package:flutter_fix_sdp/views/firebase_view.dart';
import 'package:flutter_fix_sdp/views/local_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final loginC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text(
          "Home",
          style: TextStyle(color: Colors.grey[200]),
        ),
        actions: [
          IconButton(
              onPressed: () {
                loginC.logout();
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //color: Colors.grey[700],
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(LocalView());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Text(
                          'Local Crud',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[200]),
                        ), // <-- Tex
                        Icon(
                          // <-- Icon
                          Icons.arrow_right_alt,
                          size: 24.0,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                        backgroundColor: Colors.blue[900]),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(EpicorView());
                      },
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(""),
                          Text('Epicor Crud',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[200])), // <-- Tex
                          Icon(
                            // <-- Icon
                            Icons.arrow_right_alt,
                            size: 24.0,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40),
                          backgroundColor: Colors.blue[900])),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(FirebaseView());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(""),
                          Text('Firebase Crud',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[200])), // <-- Tex
                          Icon(
                            // <-- Icon
                            Icons.arrow_right_alt,
                            size: 24.0,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40),
                          backgroundColor: Colors.blue[900]))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
