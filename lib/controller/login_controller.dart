import 'package:flutter/material.dart';
import 'package:flutter_fix_sdp/services/login_service.dart';
import 'package:flutter_fix_sdp/views/home_view.dart';
import 'package:flutter_fix_sdp/views/login_view.dart';
import 'package:get/get.dart';

import '../models/response_api.dart';

class LoginController extends GetxController {
  var username = TextEditingController();
  var password = TextEditingController();

  var isUsernameEmpty = false.obs;
  var isPasswordEmpty = false.obs;

  var isLoading = false.obs;

  Future<void> login() async {
    Map<dynamic, dynamic> data = {
      'username': username.text,
      'password': password.text
    };
    try {
      isLoading.value = true;
      ResponseApi response = await LoginService().login(data);
      if (response.code == 200) {
        Future.delayed(const Duration(seconds: 1), () {
          isLoading.value = false; // Set isloading to false after 2 second.
          Get.off(HomeView()); // go to home page
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.snackbar("Login Fail", "username or password is wrong",
              colorText: Color.fromARGB(255, 255, 255, 255),
              duration: Duration(milliseconds: 1350));
          isLoading.value = false; // go to home page
        });
      }
    } catch (e) {}
  }

  void logout() {
    password.clear();
    Get.off(LoginView());
  }
}
