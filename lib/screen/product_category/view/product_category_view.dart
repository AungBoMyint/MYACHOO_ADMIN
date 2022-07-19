import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/screen/product_category/view/product_category_manage.dart';
import 'package:kozarni_ecome/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../controller/home_controller.dart';

class ProductCategoryView extends StatefulWidget {
  const ProductCategoryView({Key? key}) : super(key: key);

  @override
  State<ProductCategoryView> createState() => _ProductCategoryViewState();
}

class _ProductCategoryViewState extends State<ProductCategoryView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: Colors.black,),
          title: const Center(child: Text("ကုန်ပစ္စည်: အုပ်စုများ",style:appBarTitleStyle)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Column(
            children: [
              
              Expanded(
                child: Obx(
                  () {
                    if (_homeController.categories.isEmpty) {
                      return const Center(
                          child: Text(
                        "No category yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: _homeController.categories.length,
                      itemBuilder: (context, index) {
                        var cate = _homeController.categories[index];

                        return InkWell(
                          onTap: () => Get.to(()=>ProductCategoryManagement(cate)),
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
                                                      cate.image ?? "https://www.sephora.com/contentimages/meganav/icons/shop_new_alt_new.svg",
                                                  fit: BoxFit.cover,
                                                ),
                                  ),
                                  const SizedBox(width: 5),
                                  //Type
                                  Expanded(
                                    child: Text(
                                      cate.name,
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
          onTap: () => Get.to(ProductCategoryManagement(null)),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: homeIndicatorColor,
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
      );
  }
}

