// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:kozarni_ecome/controller/upload_controller.dart';
// import 'package:kozarni_ecome/widgets/animate_size_list/sizeprice_item.dart';

// class AnimateSizeList extends StatefulWidget {
//   const AnimateSizeList({Key? key}) : super(key: key);

//   @override
//   State<AnimateSizeList> createState() => _AnimateSizeListState();
// }

// class _AnimateSizeListState extends State<AnimateSizeList> {
//   @override
//   Widget build(BuildContext context) {
//     UploadController _uploadController = Get.find();
//     return Obx((){
//       final sizeList = _uploadController.sizePriceMap.entries.map((e) => e.value).toList();
//       return Container(
//         height: 200,
//         child: AnimatedList(
//           key: _uploadController.animateListkey,
//           initialItemCount: sizeList.length,
//           padding: const EdgeInsets.all(10),
//           itemBuilder: (_, index, animation) {
//             final size = sizeList[index];
//             return SizeTransition(
//               key: UniqueKey(),
//               sizeFactor: animation,
//               child: SizePriceItemWidget(
//                 id: size.id, 
//                 sizeText: size.size, 
//                 index: index, 
//                 price: size.price,
//                 ),
//             );
//           },
//         ),
//       );
//     });
//   }
// }