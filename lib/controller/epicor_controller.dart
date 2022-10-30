import 'package:flutter/material.dart';
import 'package:flutter_fix_sdp/models/epicor_model.dart';
import 'package:flutter_fix_sdp/models/response_api.dart';
import 'package:flutter_fix_sdp/services/epicor_service.dart';
import 'package:get/get.dart';
import 'dart:math';

class EpicorController extends GetxController {
  var addText = TextEditingController();
  var editText = TextEditingController();
  var isAddTextEmpty = false.obs;
  var isEditTextEmpty = false.obs;
  var isLoading = false.obs;
  var isDataEmpty = false.obs;
  var isAddSuccess = true.obs;
  var isUpdateSuccess = true.obs;
  var isLoadingDelete = false.obs;
  int datalength = 0;

  List<EpicorModel> model = <EpicorModel>[].obs;

  Future<void> getList() async {
    isLoading.value = true;
    ResponseApi response = await EpicorService().getList();
    if (response.code == 200) {
      model = response.data;
      print(model);
      Future.delayed(const Duration(milliseconds: 250), () {
        isLoading.value = false; // Set isloading to false after 2 second.
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // Set isloading to false after 2 second.
        isDataEmpty.value = true;
      });
    }
    if (model.length > 0) {
      isDataEmpty.value = false;
    } else {
      isAddTextEmpty.value = true;
    }
    addText.clear();
  }

  Future<void> addData(int length) async {
    EpicorModel model = EpicorModel(id: "${length + 1}");
    model.textInput = addText.text;
    ResponseApi response = await EpicorService().add(model);
    if (response.code == 200) {
      Get.back();
      Get.snackbar("Sucess", "data already added.",
          colorText: Color.fromARGB(255, 255, 255, 255),
          duration: Duration(milliseconds: 1550));
      await getList();
    } else {
      isAddSuccess.value = false;
    }
  }

  Future<void> updateData(EpicorModel model) async {
    model.textInput = editText.text;
    ResponseApi response = await EpicorService().add(model);
    if (response.code == 200) {
      Get.back();
      Get.snackbar("Sucess", "data already updated.",
          colorText: Color.fromARGB(255, 255, 255, 255),
          duration: Duration(milliseconds: 1550));
      await getList();
    } else {
      isAddSuccess.value = false;
    }
  }

  Future<void> deleteData(String id) async {
    ResponseApi response = await EpicorService().deleteData(id);
    if (response.code == 200) {
      Get.back();
      Get.snackbar("Sucess", "data already removed.",
          colorText: Color.fromARGB(255, 255, 255, 255),
          duration: Duration(milliseconds: 1550));
      await getList();
    } else {
      Get.back();
      Get.snackbar("Failed", response.status,
          colorText: Color.fromARGB(255, 255, 255, 255),
          duration: Duration(milliseconds: 1350));
    }
  }

  void updateIsDone(EpicorModel model) async {
    await EpicorService().updateIsDone(model);
    getList();
  }

  bool isRowChecked(bool data) {
    if (data) return true;
    return false;
  }

  void getEditValue(EpicorModel model) {
    editText.text = model.textInput.toString();
  }

  int getKeyTerbesar(List<EpicorModel> models) {
    var key = <int>[];
    for (var e in models) {
      key.add(int.parse(e.id));
    }
    int result = key.reduce((curr, next) => curr > next ? curr : next);
    return result;
  }

  @override
  void onInit() {
    getList();
    super.onInit();
  }
}
