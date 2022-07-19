import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/data/mock.dart';

List<String> category = [
  'all',
  'machine tools',
  'man',
  'woman',
];

class HomeCategory extends StatelessWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Container(
      width: double.infinity,
      height: 40,

      // color: Colors.green,
      child:  Obx(
        () {
          return controller.categories.length > 0 ? ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (_, i) {
                      final cate = controller.categories[i];
                      return Container(
                      margin: EdgeInsets.only(
                        top: 3,
                        bottom: 3,
                        right: 20,
                      ),
                      child: Obx(
                        () => ElevatedButton(
                        
                          style: ButtonStyle(
                            backgroundColor: controller.category.value ==
                                    cate.name
                                ? MaterialStateProperty.all(homeIndicatorColor)
                                : MaterialStateProperty.all(Colors.white),
                            foregroundColor: controller.category.value ==
                                    cate.name
                                ? MaterialStateProperty.all(Colors.white)
                                : MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            controller.changeCat(cate.name);
                          },
                          child: Text(
                            cate.name,
                            style: TextStyle(color:controller.category.value ==
                                    cate.name ? Colors.white: Colors.black,),
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


// Container(
//           margin: EdgeInsets.only(
//             right: 10,
//             top: 7,
//             bottom: 7,
//           ),
//           padding: EdgeInsets.only(left: 20, right: 20),
//           height: 50,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: homeIndicatorColor,
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 spreadRadius: 1,
//                 blurRadius: 1,
//                 offset: Offset(0, 1),
//               )
//             ],
//           ),
//           child: Text(
//             category[i],
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//             ),
//           ),
//         )
