import 'package:flutter/material.dart';
import 'package:get/get.dart';

showNotEnoughPoint() {
  Get.dialog(
    Center(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          height: 100,
          width: 200,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              // border: Border.all(
              //   color: Colors.red,
              //   width: 2,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Sorry!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text("your points is not enough.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0),
  );
}
