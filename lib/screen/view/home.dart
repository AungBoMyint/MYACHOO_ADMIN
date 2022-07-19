import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/data/mock.dart';
import 'package:kozarni_ecome/model/view_all_model.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:kozarni_ecome/widgets/home_category.dart';
import 'package:kozarni_ecome/widgets/home_category_main.dart';
import 'package:kozarni_ecome/widgets/home_pickup.dart';
import 'package:kozarni_ecome/widgets/normal_product_widget.dart';
import 'package:kozarni_ecome/widgets/reward_product_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
                children: [
                  //Category
                  HomeCategoryMain(),
                  const SizedBox(height: 10,),
                  //Advertisement
                  HomePickUp(),
                  // Obx(
                  //   () {
                  //     return controller.advertisementList.length > 0 ? AspectRatio(
                  //       aspectRatio: 16/10,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         shrinkWrap: true,
                  //         itemCount: controller.advertisementList.length,
                  //         itemBuilder: (context,index){
                  //           final advertisement = controller.advertisementList[index];
                  //           return AspectRatio(
                  //             aspectRatio: 16/10,
                  //             child:  CachedNetworkImage(
                  //                     progressIndicatorBuilder: (context, url, status) {
                  //       return Shimmer.fromColors(
                  //         baseColor: Colors.red,
                  //         highlightColor: Colors.yellow,
                  //         child: Container(color: Colors.white,),
                  //       );
                  //                     },
                  //                     errorWidget: (context, url, whatever) {
                  //       return const Text("Image not available");
                  //                     },
                  //                     imageUrl:
                  //         advertisement.image,
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //             );
                  //         },
                  //         ),
                  //     ) : const SizedBox();
                  //   }
                  // ),
                   Obx(
                     () {
                       return controller.statusList.length > 1 ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: controller.statusList.length,
                          itemBuilder: (context,index){
                            
                            final sta = controller.statusList[index];
                            final products = controller.items.where((element) => element.status == sta.name).toList();
                              if(products.length > 0){
                                if(!(products[0].requirePoint! > 0)){
                                  //If this products list is not reward list,how do we know reward list or not?
                                  //we check first product's require point is greather than 0 then this is reward list,
                                  //or not.
                                //OTHER WIDGET 
                                return AspectRatio(aspectRatio: 16/13,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    
                                    top: 20,
                                  ),
                                  child: Column(
                                    
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,right: 10,bottom: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            //Status Text
                                             Text(
                                                sta.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            
                                            //See More
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: (){
                                                  controller.setViewAllProducts(
                                                    ViewAllModel(status: sta.name, products: products)
                                                  );
                                                  Get.toNamed(viewAllUrl);
                                                },
                                                child: Text(
                                                  "Show More",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                                                                child: ListView.builder(
                                                                                  physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: products.length,
                                          itemBuilder: (context,productIndex){
                                            return NormalProductWidget(product: products[productIndex]);
                                          },
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                );
                              }else{
                                //REWARD WIDGET
                                return AspectRatio(aspectRatio: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,right: 10,bottom: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            //Status Text
                                             Text(
                                                sta.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            
                                            //See More
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: (){
                                                  controller.setViewAllProducts(
                                                    ViewAllModel(status: sta.name, products: products)
                                                  );
                                                  Get.toNamed(viewAllUrl);
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: products.length,
                                          itemBuilder: (context,productIndex){
                                            return RewardProductWidget(product: products[productIndex]);
                                          },
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                );
                              }
                              }else{
                                return const SizedBox();
                              }
                          },
                          ) : const SizedBox();
                     }
                   ),
                //const SizedBox(height: 100,),    
                ],
              ),
    );
  }
}
