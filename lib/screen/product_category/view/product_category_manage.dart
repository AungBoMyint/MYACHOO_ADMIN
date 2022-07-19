import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/model/category.dart';
import 'package:kozarni_ecome/widgets/shimmer/image_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/home_controller.dart';
import '../../../data/constant.dart';
import '../../../model/advertisement.dart';
import '../../../utils/utils.dart';
import '../../../widgets/home_category.dart';

class ProductCategoryManagement extends StatefulWidget {
  final Category? category;
  const ProductCategoryManagement(this.category,{ Key? key}) : super(key: key);

  @override
  State<ProductCategoryManagement> createState() => _ProductCategoryManagementState();
}

class _ProductCategoryManagementState extends State<ProductCategoryManagement> {
  late Input input;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedMainId = "";
  
  @override
  void initState() {
    selectedMainId = widget.category?.mainId??"";
    input = Input(input: {
      "name": TextEditingController()..text = widget.category?.name ?? "",
      "image": TextEditingController()..text = widget.category?.image ?? "",
    });
    super.initState();
  }

  void selectId(String value){
    if(mounted){
      setState((){
        selectedMainId = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text("ကြော်ငြာ ပုံစံ",style: appBarTitleStyle,)),
          actions: [
          if (!(widget.category == null)) ...[
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
                    _homeController.deleteCategory(widget.category?.id ?? ""),
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
              onPressed: () => _homeController.addCategory(
                Category(
                  name: input.input["name"]?.value.text ?? "", 
                  image: input.input["image"]?.value.text ?? "",
                  id: widget.category?.id ?? Uuid().v1(),
                  mainId: selectedMainId,
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
                    child: Text("Name",
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
                    child: Text("Image",
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                  ),
                  TextFormField(
                    controller: input.input["image"],
                    keyboardType: TextInputType.text,
                    validator: input.validateInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            //ToSelectMainCategory
            SizedBox(
          height: 50,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCategoryList.length,
                  itemBuilder: (_, i) {
    final tag = mainCategoryList[i];
                    final equal = selectedMainId==tag;

                    return Container(
                      margin: EdgeInsets.only(
                        top: 3,
                        bottom: 3,
                        right: 20,
                      ),
                      child: ChoiceChip(
                              selectedColor: homeIndicatorColor,
                              onSelected: (v) => selectId(tag),
                              label: Text(
                                tag,
                                style: TextStyle(
                                  color: equal ? Colors.white: Colors.grey,
                                ),
                              ),
                              selected: equal,
                            ),

                    );}
              ),
            )
          ],
        ),
      ),      
    );
  }
}