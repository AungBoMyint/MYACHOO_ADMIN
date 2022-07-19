import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../controller/upload_controller.dart';
import '../data/constant.dart';

class TagButtonList extends StatelessWidget {
  const TagButtonList({ Key? key }) : super(key: key);

  
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
          return controller.tagsList.isNotEmpty ? ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.tagsList.length,
                    itemBuilder: (_, i) {
                      final tag = controller.tagsList[i];
                      return Container(
                      margin: EdgeInsets.only(
                        top: 3,
                        bottom: 3,
                        right: 20,
                      ),
                      child: Obx(
                        () {
                          final isContain = uploadController.tagsMap.containsKey(tag.id) || 
                          (!(controller.editItem.value == null) && (controller.editItem.value!.tags.contains(tag.name)));
                          return ChoiceChip(
                            selectedColor: homeIndicatorColor,
                            onSelected: (v) => uploadController.addOrRemoveTag(tag.id, tag.name),
                            label: Text(
                              tag.name,
                              style: TextStyle(
                                color: isContain ? Colors.white: Colors.grey,
                              ),
                            ), 
                            selected: isContain,
                            );
                        }
                      ),
                    );}
          ) : const SizedBox();
        }
      )
    );
  }
}