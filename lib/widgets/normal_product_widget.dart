import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/model/product.dart';

import '../controller/home_controller.dart';
import '../routes/routes.dart';

class NormalProductWidget extends StatelessWidget {
  final Product product;
  const NormalProductWidget({ Key? key,required this.product }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return  InkWell(
      onTap: (){
         _homeController.setEditItem(product);
                    Get.toNamed(detailScreen);
      },
      child: ConstrainedBox(
                  constraints: BoxConstraints(
                  maxHeight: 200,
                  ),
        child:  Card(
                   elevation: 5,
                        child:  Stack(
                          children: [
                          
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 5,),
                                    Expanded(
                                      flex: 1,
                                      child: Hero(
                                        tag: product.photo1,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
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
                                      padding: const EdgeInsets.all(0),
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
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(0),
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
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 5,
                                                        top: 2,
                                                      ),
                                                      child: Text(
                                                         "${product.price} Kyats",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              
                                                                    ),
                                            
                                                                       ),
                                     ),
                                  ],
                                ),
                            ),
                            //Tags
                            Align(
                              alignment: Alignment.topLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 150,
                                  maxWidth: 150,
                                ),
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context,index){
                                    return const SizedBox(height: 2,);
                                  },
                                  itemCount: product.tags.length,
                                  itemBuilder: (context,index){
                                    final tag = product.tags[index];
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                        padding: EdgeInsets.all(3),
                                        child: Text(tag,style: TextStyle(color: Colors.white,),),),);
                                    
                                  },
                                  ),
                              ),
                            ),
                          ],
                        ),
          ),
        
      
                  ),
    );
  }
}