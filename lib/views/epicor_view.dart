import 'package:flutter/material.dart';
import 'package:flutter_fix_sdp/controller/epicor_controller.dart';
import 'package:flutter_fix_sdp/controller/helper_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class EpicorView extends StatelessWidget {
  final epicorC = Get.put(EpicorController());
  final helperC = Get.put(HelperController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          actions: [
            IconButton(
                onPressed: () {
                  epicorC.getList();
                },
                icon: Icon(Icons.refresh))
          ],
          title: Text(
            "Crud Epicor",
            style: TextStyle(color: Colors.grey[200]),
          )),
      body: Obx(
        () => epicorC.isDataEmpty.value
            ? Center(child: Text("Data is empty.."))
            : Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Obx(
                  () => epicorC.isLoading.value
                      ? Center(
                          child: Container(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.blue[900],
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (contex, index) {
                            return (ListTile(
                              onTap: () {
                                var isCheked = epicorC
                                    .isRowChecked(epicorC.model[index].isDone);
                                if (isCheked) {
                                  Get.snackbar(
                                      "Failed", "Please unchacked this row!",
                                      colorText:
                                          Color.fromARGB(255, 255, 255, 255),
                                      duration: Duration(milliseconds: 1350));
                                } else {
                                  epicorC.getEditValue(epicorC.model[index]);
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      title: "Edit",
                                      content: Column(
                                        children: [
                                          Obx(
                                            () => epicorC.isUpdateSuccess.value
                                                ? Center()
                                                : Center(
                                                    child: Text(
                                                      "Update data failed!",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                              controller: epicorC.editText,
                                              minLines:
                                                  3, // any number you need (It works as the rows for the textarea)
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 4,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                  hintText:
                                                      "type something here..",
                                                  labelText: "edit",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey[300]),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors.green)),
                                                  errorText: (false)
                                                      ? "input cannot be empty!"
                                                      : null)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  "cancel",
                                                  style: TextStyle(
                                                      color: Colors.grey[200]),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // if (epicorC
                                                  //     .isAddTextEmpty.value) {
                                                  //   epicorC.isAddTextEmpty
                                                  //       .value = true;
                                                  // } else {
                                                  //   epicorC.updateData(
                                                  //       epicorC.model[index]);
                                                  // }
                                                  epicorC.updateData(
                                                      epicorC.model[index]);
                                                },
                                                child: Text(
                                                  "update",
                                                  style: TextStyle(
                                                      color: Colors.grey[300],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue[900]),
                                              ),
                                            ],
                                          )
                                        ],
                                      ));
                                }
                              },
                              title: Text(
                                epicorC.model[index].textInput.toString(),
                                style: (epicorC.model[index].isDone)
                                    ? TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough)
                                    : TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color),
                              ),
                              leading: Checkbox(
                                onChanged: (value) {
                                  var changed = epicorC.model[index];
                                  changed.isDone = value!;
                                  epicorC.model[index] = changed;
                                  epicorC.updateIsDone(epicorC.model[index]);
                                },
                                value: epicorC.model[index].isDone,
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[400],
                                  size: 20,
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "Warning!",
                                      middleText:
                                          "This data will be deleted, are you sure?",
                                      backgroundColor: Colors.grey[200],
                                      textCancel: "No",
                                      textConfirm: "Yes",
                                      onCancel: () {},
                                      onConfirm: () {
                                        epicorC.deleteData(
                                            epicorC.model[index].id.toString());
                                      },
                                      buttonColor: Colors.blue[900],
                                      confirmTextColor: Colors.white,
                                      barrierDismissible: false);
                                },
                              ),
                            ));
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                height: 0,
                              ),
                          itemCount: epicorC.model.length),
                )),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Get.defaultDialog(
              barrierDismissible: false,
              title: "Add",
              content: Column(
                children: [
                  Obx(
                    () => epicorC.isAddSuccess.value
                        ? Center()
                        : Center(
                            child: Text(
                              "Add data failed!",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: epicorC.addText,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          epicorC.isAddTextEmpty.value = false;
                        } else {
                          epicorC.isAddTextEmpty.value = true;
                        }
                      },
                      autofocus: true,
                      minLines:
                          3, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: "type something here..",
                          labelText: "add",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green)),
                          errorText:
                              (false) ? "input cannot be empty!" : null)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          epicorC.addText.clear();
                          //epicorC.isAddTextEmpty.value = false;
                          Get.back();
                        },
                        child: Text(
                          "cancel",
                          style: TextStyle(color: Colors.grey[200]),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // if (epicorC.addText.text.isEmpty) {
                          //   epicorC.isAddTextEmpty.value = true;
                          // } else {
                          //   epicorC.isAddTextEmpty.value = false;
                          var keyTerbesar =
                              epicorC.getKeyTerbesar(epicorC.model);
                          if (keyTerbesar < 1) {
                            keyTerbesar = 0;
                          }

                          epicorC.addData(keyTerbesar);
                        },
                        //},
                        child: Center(
                          child: epicorC.isLoading.value
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "add",
                                  style: TextStyle(
                                      color: Colors.grey[300],
                                      fontWeight: FontWeight.bold),
                                ),
                        ),

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900]),
                      ),
                    ],
                  ),
                ],
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
