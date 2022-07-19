import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/model/category.dart';
import 'package:kozarni_ecome/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/home_controller.dart';
import '../../model/tag.dart';
import '../../widgets/button/button.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({Key? key}) : super(key: key);

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Input input = Input(input: {
    "tag": TextEditingController(),
  });

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: Colors.black,),
          title: const Center(child: Text("Tags အုပ်စုများ",style: appBarTitleStyle,)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            top: 20,
          ),
          child: Column(
            
            children: [
              Form(
                key: formKey,
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: input.input.values.first,
                validator: input.validateInput,
                decoration: InputDecoration(
                  //hintText: ,
                  border: OutlineInputBorder(),
                
              ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                       ExButton(
                          color: homeIndicatorColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          label: "Add",
                          height: 36.0,
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              _homeController.addTag(
                              Tag(name: input.input.values.first.text, 
                              id: Uuid().v1(), 
                              dateTime: DateTime.now(),
                              ),
                            );
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    if (_homeController.categories.isEmpty) {
                      return const Center(
                          child: Text(
                        "No tag yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: _homeController.tagsList.length,
                      itemBuilder: (context, index) {
                        var cate = _homeController.tagsList[index];

                        return InkWell(
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Text(cate.name),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                       _homeController.deleteTag(cate.id);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                      ),
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
        ));
  }
}
