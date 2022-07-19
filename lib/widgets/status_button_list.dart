
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/upload_controller.dart';

import '../controller/home_controller.dart';
import '../data/constant.dart';

class StatusButtonList extends StatelessWidget {
  const StatusButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final UploadController uploadController = Get.find();
    return Container(
      width: double.infinity,
      height: 40,

      // color: Colors.green,
      child:  Obx(
        () {
          return controller.statusList.isNotEmpty ? ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.statusList.length,
                    itemBuilder: (_, i) {
                      final status = controller.statusList[i];
                      return Container(
                      margin: EdgeInsets.only(
                        top: 3,
                        bottom: 3,
                        right: 20,
                      ),
                      child: Obx(
                        () => ElevatedButton(
                        
                          style: ButtonStyle(
                            backgroundColor: uploadController.status.value ==
                                    status.name
                                ? MaterialStateProperty.all(homeIndicatorColor)
                                : MaterialStateProperty.all(Colors.white),
                            foregroundColor: uploadController.status.value ==
                                    status.name
                                ? MaterialStateProperty.all(Colors.white)
                                : MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            uploadController.changeStatus(status.name);
                          },
                          child: Text(
                            status.name,
                            style: TextStyle(color: uploadController.status.value ==
                                    status.name ?Colors.white :Colors.black,),
                          ),
                        ),
                      ),
                    );}
          ) : const SizedBox();
        }
      )
    );
  }
}
