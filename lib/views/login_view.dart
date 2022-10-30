import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fix_sdp/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final loginC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[900],
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            child: Column(children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Welcome Back,",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[300]),
              ),
              Text(
                "Log in now to continue",
                style: TextStyle(color: Colors.grey[400]),
              )
            ]),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50]),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.android_rounded,
                    size: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => TextField(
                        controller: loginC.username,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            loginC.isUsernameEmpty.value = false;
                          } else {
                            loginC.isUsernameEmpty.value = true;
                          }
                        },
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            hintText: "Username",
                            labelText: "username",
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.green)),
                            errorText: (loginC.isUsernameEmpty.value)
                                ? "username cannot be empty!"
                                : null)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => TextField(
                        controller: loginC.password,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            loginC.isPasswordEmpty.value = false;
                          } else {
                            loginC.isPasswordEmpty.value = true;
                          }
                        },
                        style: TextStyle(fontSize: 18),
                        obscuringCharacter: "*",
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            hintText: "your password",
                            labelText: "password",
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.green)),
                            errorText: (loginC.isPasswordEmpty.value)
                                ? "password cannot be empty!"
                                : null)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                      onPressed: () {
                        if (loginC.username.text.isEmpty) {
                          loginC.isUsernameEmpty.value = true;
                        }
                        if (loginC.password.text.isEmpty) {
                          loginC.isPasswordEmpty.value = true;
                        }
                        if (loginC.username.text.isNotEmpty &&
                            loginC.password.text.isNotEmpty) {
                          loginC.login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          textStyle: TextStyle(fontSize: 17)),
                      child: Center(
                        child: loginC.isLoading.value
                            ? Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300]),
                              ),
                      )))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
