import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../photo_viewer/photo_viewer.dart';
import '../purchase_dialog_box/purchase_dialog_box.dart';

class PrePay extends StatelessWidget {
  const PrePay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return ListView.builder(
      itemCount: controller.purchcasesPrePay().length,
      itemBuilder: (_, i) {
        List town = controller.purchcasesPrePay()[i].deliveryTownshipInfo;
        final shipping = town[1];
        final townName = town[0];
        return AspectRatio(
          aspectRatio: 16 / 4,
          child: Card(
            elevation: 5,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Name,Phone and Date ListTile
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      onTap: () {
                        int total = 0;
                        for (var item
                            in controller.purchcasesPrePay()[i].items) {
                          total += item.price * item.count;
                        }

                        print(controller.purchcasesPrePay()[i].items.length);
                        Get.defaultDialog(
                          title: "Customer ၀ယ်ယူခဲ့သော အချက်အလက်များ",
                          titleStyle: TextStyle(fontSize: 12),
                          radius: 5,
                          content: purchaseDialogBox(
                            context: context,
                              i: i,
                              total: total,
                              shipping: shipping,
                              township: townName,
                              list: controller.purchcasesPrePay()),
                        );
                      },
                      title: Text(
                          "${controller.purchcasesPrePay()[i].name} 0${controller.purchcasesPrePay()[i].phone}"),
                      subtitle: Text(
                          "${DateTime.parse(controller.purchcasesPrePay()[i].dateTime).day}/${DateTime.parse(controller.purchcasesPrePay()[i].dateTime).month}/${DateTime.parse(controller.purchcasesPrePay()[i].dateTime).year}"),
                    ),
                  ),
                  //PhotoView
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        //Show Dialog PhotoView
                        showDialog(
                          //barrierColor: Colors.white.withOpacity(0),
                          context: Get.context!,
                          builder: (context) {
                            return photoViewer(
                                heroTags: controller
                                        .purchcasesPrePay()[i]
                                        .bankSlipImage ??
                                    "");
                          },
                        );
                      },
                      child: Hero(
                        tag: controller.purchcasesPrePay()[i].bankSlipImage ??
                            "",
                        child: CachedNetworkImage(
                          httpHeaders: {
                            "maxAgeSeconds": "3600",
                            "method": "GET, HEAD",
                            "Access-Control-Allow-Origin": "*",
                            "Access-Control-Allow-Methods": "POST,HEAD",
                            "responseHeader": "Content-Type",
                          },
                          imageUrl:
                              controller.purchcasesPrePay()[i].bankSlipImage ??
                                  "",
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, status) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  value: status.progress,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
