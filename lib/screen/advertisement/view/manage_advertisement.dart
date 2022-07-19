import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/widgets/shimmer/image_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/home_controller.dart';
import '../../../data/constant.dart';
import '../../../model/advertisement.dart';
import '../../../utils/utils.dart';
import '../../../widgets/home_category.dart';
import '../controller/advertisement_controller.dart';

class ManageAdvertisementScreen extends StatefulWidget {
  final Advertisement? advertisement;
  const ManageAdvertisementScreen(this.advertisement,{ Key? key}) : super(key: key);

  @override
  State<ManageAdvertisementScreen> createState() => _ManageAdvertisementScreenState();
}

class _ManageAdvertisementScreenState extends State<ManageAdvertisementScreen> {
  late Input input;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    Get.put(AdvertisementController(widget.advertisement));
    input = Input(input: {
      "image": TextEditingController()..text = widget.advertisement?.image ?? "",
      "description": TextEditingController()..text = widget.advertisement?.description ?? "",
    });
    super.initState();
  }
  @override
  void dispose() {
    Get.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AdvertisementController _adController = Get.find();
    HomeController _homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text("ကြော်ငြာ ပုံစံ",style: appBarTitleStyle,)),
          actions: [
          if (!(widget.advertisement == null)) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: homeIndicatorColor,
                ),
                child: Text("Delete"),
                onPressed: () =>
                    _adController.deleteAdvertisement(widget.advertisement?.id ?? ""),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: homeIndicatorColor,
              ),
              child: Text("Save"),
              onPressed: () => _adController.saveAdvertisement(
                Advertisement(
                  id: widget.advertisement?.id ?? Uuid().v1(), 
                  image: input.input["image"]?.text ?? "", 
                  description: input.input["description"]?.text ?? "", 
                  products: _adController.advertisementProductMap, 
                  dateTime: DateTime.now(),
                  ),
              ),
            ),
          ),
        ],
        elevation: 5,
        backgroundColor: detailBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black,),
        ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            //Image Url
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Hint Text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Image",
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                  ),
                  TextFormField(
                    controller: input.input.values.first,
                    keyboardType: TextInputType.text,
                    validator: input.validateInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            //Description
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Hint Text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Description",
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                  ),
                  TextFormField(
                    controller: input.input["description"],
                    keyboardType: TextInputType.text,
                    validator: input.validateInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            //Put products which include inside this advertisement
            Expanded(
              child: Column(
                children: [
                  //text
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5),
                    child: Text("Choose products which include in this advertisement:",
                    style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),),
                  ),
                  const SizedBox(height: 5,),
                  //CategoryList
                  HomeCategory(),
                  const SizedBox(height: 10,),
                  //Product List
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,),
                      child: Obx(
                         () {
                           final products = _homeController.items.where((e) => e.category == _homeController.category.value).toList();
                           debugPrint("******Rebuild products: ${products.length}");
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              ), 
                            itemCount: products.length,
                            itemBuilder: (context,index){
                              final item = products[index];
                              return Obx((){
                                final isContain = _adController.advertisementProductMap.containsKey(item.id) ||
                                 widget.advertisement!.products.containsKey(item.id);
                                return InkWell(
                                  onTap: () => _adController.addOrRemove(item.id),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 200,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isContain ? Colors.green : Colors.grey,
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          //Image
                                          Expanded(
                                            flex: 2,
                                            child: CachedNetworkImage(
                                                progressIndicatorBuilder: (context, url, status) {
                                                            return ImageShimmerWidget();
                                                },
                                                errorWidget: (context, url, whatever) {
                                                            return const Text("Image not available");
                                                },
                                                imageUrl:
                                                              item.photo1,
                                                fit: BoxFit.cover,
                                              ),
                                          ),
                                          //name
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(item.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                
                                              ),maxLines: 2,overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                            );
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),      
    );
  }
}