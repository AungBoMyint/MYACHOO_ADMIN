import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading() async {
  await Get.dialog(
    Container(
      child: Stack(
        children: [
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

hideLoading() {
  Get.back();
}

hideSaving() {
  Get.back();
}

showSaving() async {
  await Get.dialog(
    Container(
      child: Stack(
        children: [
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Saving....",style: TextStyle(
                  color: Colors.black,
                )),
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}
