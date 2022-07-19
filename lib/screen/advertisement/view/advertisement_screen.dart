import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/model/advertisement.dart';
import 'package:kozarni_ecome/model/category.dart';
import 'package:kozarni_ecome/screen/advertisement/controller/advertisement_controller.dart';
import 'package:kozarni_ecome/utils/utils.dart';
import 'package:kozarni_ecome/widgets/home_category.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

import '../../../../controller/home_controller.dart';
import '../../../widgets/button/button.dart';
import 'manage_advertisement.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: Colors.black,),
          title: const Center(child: Text("ကြော်ငြာ အုပ်စုများ",style:appBarTitleStyle)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Column(
            children: [
              // Form(
              //   key: formKey,
              //   child: Container(
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: SizedBox(
              //             height: 50,
              //             child: TextFormField(
              //               onChanged: (value) => input.input['advertisement'] = value,
              //   validator: input.validateInput,
              //   decoration: InputDecoration(
              //     //hintText: ,
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 10.0,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 22.0),
              //           child: ExButton(
              //             color: homeIndicatorColor,
              //             borderRadius: BorderRadius.all(Radius.circular(10)),
              //             label: "Add",
              //             height: 36.0,
              //             onPressed: () {
              //               if(formKey.currentState!.validate()){
              //                 _homeController.addCategory(
              //                 Category(name: input.input.values.first, 
              //                 id: Uuid().v1(), 
              //                 dateTime: DateTime.now(),
              //                 ),
              //               );
              //               }
              //             },
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: Obx(
                  () {
                    if (_homeController.advertisementList.isEmpty) {
                      return const Center(
                          child: Text(
                        "No advertisement yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: _homeController.advertisementList.length,
                      itemBuilder: (context, index) {
                        var advertisement = _homeController.advertisementList[index];

                        return InkWell(
                          onTap: () => Get.to(ManageAdvertisementScreen(advertisement)),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 150,
                              maxHeight: 200,
                            ),
                            child: Card(
                              child: Row(
                                children: [
                                  //Advertisement IMAGE
                                  Expanded(
                                    child: CachedNetworkImage(
                                                  progressIndicatorBuilder: (context, url, status) {
                                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white,
                                      child: Container(color: Colors.white,),
                                    );
                                                  },
                                                  errorWidget: (context, url, whatever) {
                                                    return const Text("Image not available");
                                                  },
                                                  imageUrl:
                                                      advertisement.image,
                                                  fit: BoxFit.cover,
                                                ),
                                  ),
                                  const SizedBox(width: 5),
                                  //Type
                                  Expanded(
                                    child: Text(
                                      advertisement.description,
                                    ),
                                    ),
                                ],
                              ),
                            ),
                            ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () => Get.to(ManageAdvertisementScreen(null)),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: homeIndicatorColor,
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
      );
  }
}

