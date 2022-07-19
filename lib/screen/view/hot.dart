import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';

class HotView extends StatelessWidget {
  const HotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        itemCount: controller.hot().length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            controller.setEditItem(controller.hot()[i]);
            Get.toNamed(detailScreen);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.hot()[i].name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${controller.hot()[i].discountPrice}  Ks",
                        style: TextStyle(
                          color: homeIndicatorColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
          Text(
            "${controller.hot()[i].price}  Ks",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: homeIndicatorColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: controller.hot()[i].photo1,
                    // "$baseUrl$itemUrl${controller.hot()[i].photo}/get",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
