import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/model/product.dart';

import '../../data/constant.dart';
import '../../routes/routes.dart';

class ViewAllRewardProductWidget extends StatelessWidget {
  final Product product;
  const ViewAllRewardProductWidget({ Key? key,required this.product }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
        return InkWell(
          onTap: (){
                    // _homeController.setEditItem(product);
                    // Get.toNamed(detailScreen);
                  },
          child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 150,
                    maxHeight: 200,
                  ),
                  child:Card(
                   elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10,),
                          Expanded(
                            flex: 1,
                            child: Hero(
                                tag: product.photo1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    imageUrl: product.photo1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ),
                          
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  product.brandName!.isNotEmpty ? 
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      product.brandName ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ): const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      bottom: 10,
                                      top: 2,
                                    ),
                                    child: Text(
                                       "${product.requirePoint} Points",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                 
                                ],
                              ),
                            ),
                          ),
                           //BUTTOM
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Obx(() {
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  side: BorderSide(
                                                    color: (_homeController
                                                                .currentUser
                                                                .value ==
                                                            null)
                                                        ? Colors.black
                                                        : homeIndicatorColor,
                                                  ))),
                                          onPressed: () {
                                            if (_homeController
                                                    .currentUser.value ==
                                                null) {
                                              _homeController
                                                  .signInWithGoogle(homeScreen);
                                            } else {
                                              debugPrint(
                                                  "*****Add to cart reward product**");

                                              _homeController.addToCart(product,price: product.price);
                                            }
                                          },
                                          child: (_homeController
                                                      .currentUser.value ==
                                                  null)
                                              ? Text("sign in to access",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ))
                                              : Text(
                                                  _homeController
                                                              .isContainRewardProductInCart(product)
                                                      ? "Added"
                                                      : "Add to cart",
                                                  style: TextStyle(
                                                    color: homeIndicatorColor,
                                                  )),
                                        ),
                                      );
                                    }),
                                  ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
  }
}