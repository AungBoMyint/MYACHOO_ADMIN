import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/screen/view_all/controller/view_all_controller.dart';
import 'package:kozarni_ecome/widgets/view_all/viewall_reward_product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/constant.dart';
import '../../../routes/routes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/view_all/viewall_normal_product.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({ Key? key }) : super(key: key);

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  void initState() {
    Get.put(ViewAllController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ViewAllController>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ViewAllController _viewAllController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          "မြခြူး Mya Choo",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
            wordSpacing: 2,
            letterSpacing: 2,
          ),
        ),
        // centerTitle: true,
        actions: [
          SizedBox(
            width: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.resolveWith<double>(
                  // As you said you dont need elevation. I'm returning 0 in both case
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return 0;
                    }
                    return 0; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () => Get.toNamed(searchScreen),
              child: FaIcon(
                FontAwesomeIcons.search,
                color: Colors.black,
                size: 23,
              ),
            ),
          ),

          SizedBox(
            width: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.resolveWith<double>(
                  // As you said you dont need elevation. I'm returning 0 in both case
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return 0;
                    }
                    return 0; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () async {
                try {
                  await launch('https://m.me/myachoonagar');
                } catch (e) {
                  print(e);
                }
              },
              child: FaIcon(
                FontAwesomeIcons.facebookMessenger,
                color: Colors.blue,
                size: 23,
              ),
            ),
          ),

          SizedBox(width: 20,),


        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Status Text Title
            Text(
              "> ${_viewAllController.status}",
              style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: appBarTitleColor,
            wordSpacing: 1,
            letterSpacing: 1,
          ),
            ),
            const SizedBox(height: 10,),
            //Filter & Sort
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //Sliders
                  Obx(
                   () {
                     final isRefresh = _viewAllController.isRefresh.value;
                      return InkWell(
                        onTap: () => _viewAllController.refreshViewAll(),
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: isRefresh ? Colors.black : Colors.grey.shade300,
                          child: Icon(FontAwesomeIcons.slidersH,size: 20, color:isRefresh ? Colors.white : Colors.black87,),
                          ),
                      );
                    }
                  ),
                  //Filter & Sort Options
                  SizedBox(
                    height: 35,
                    child: Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Obx(
                              () {
                                final sortPriceText = (_viewAllController.sortPrice.value == SortPrice.lowToHigh) ?
                                "Sort: Price Low To High" : (_viewAllController.sortPrice.value == SortPrice.highToLow) ?
                                "Sort: Price High To Low": "Sort: Price"; 
                                final isEqual = _viewAllController.sortPrice.value != SortPrice.none;
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:isEqual ? Colors.black : Colors.grey.shade300,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    )
                                  ),
                                  onPressed: () => showModalBottomSheet(
                                    context: context, 
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft:Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context){
                                    return Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        )
                                      ),
                                      padding: EdgeInsets.only(left: 10,right: 10,),
                                      child: Stack(
                                        children: [
                                          //-------------Close----//
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                onPressed: (){
                                                  Get.back();
                                                },
                                                icon: Icon(Icons.close,color: Colors.black,),
                                            )),
                                          //-----------Filter & Sort Widget---//
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 20),
                                                      Text(
                                                    "Filter & Sort",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //---------Diveider----//
                                                  Divider(
                                                    color: Colors.grey,
                                                  ),
                                                //
                                                Obx(
                                                  (){
                                                    return RadioListTile<SortPrice>(
                                                      title: Text("Price: Low To High"),
                                                      value: SortPrice.lowToHigh,
                                                      activeColor: Colors.black,
                                                      groupValue: _viewAllController.sortPrice.value, 
                                                      onChanged:(SortPrice? value) {
                                                        
                                                         _viewAllController.changeSortPrice(value!);
                                                      }
                                                      );
                                                  }
                                                ),
                                                Obx(
                                                  (){
                                                    return RadioListTile<SortPrice>(
                                                      title: Text("Price: High To Low"),
                                                      value: SortPrice.highToLow,
                                                      activeColor: Colors.black,
                                                      groupValue: _viewAllController.sortPrice.value, 
                                                      onChanged:(SortPrice? value) {
                                                         _viewAllController.changeSortPrice(value!);
                                                        
                                                      }
                                                      );
                                                  }
                                                ),
                                                
                                              ]
                                            ),
                                          ),
                                          //---Clear All & Show Result
                                          Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () => _viewAllController.refreshViewAll(),
                                                        child: Text("Clear all",style: TextStyle(color: Colors.blue,),)),
                                                      ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                            primary: Colors.black,
                                                                            elevation: 0,
                                                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                            )
                                                                          ),onPressed: () => _viewAllController.sortingPriceList(), child: Text("Show Results"),),
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  }), 
                                  child: Row(
                                    children: [
                                      Text(
                                  "$sortPriceText ",
                                  style: TextStyle(
                                    color: isEqual ? Colors.white: Colors.black87,
                                  ),
                                ),
                                Icon(FontAwesomeIcons.caretDown,color: isEqual ? Colors.white: Colors.black87,)
                                    ],
                                  ),);
                              }
                            ),
                          ),
                  ),
                   SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _viewAllController.viewAllCategories.length,
                        itemBuilder: (context,index){
                          final category = _viewAllController.viewAllCategories[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Obx(
                              () {
                                final isEqual = _viewAllController.category.value == category;
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:isEqual ? Colors.black : Colors.grey.shade300,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    )
                                  ),
                                  onPressed: () => _viewAllController.changeAllViewCategory(category), 
                                  child: Text(
                                  category,
                                  style: TextStyle(
                                    color: isEqual ? Colors.white: Colors.black87,
                                  ),
                                ));
                              }
                            ),
                          );
                        },
                      
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            //-----Result----//
            Obx(() => _viewAllController.isRefresh.value ? const SizedBox() :
            Text(
              "${_viewAllController.viewAllResultProducts.length} Results",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            ),
            const SizedBox(height: 10,),
            //Result Grid Products
            Expanded(
              child: Obx(
                 () {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                      ), 
                    itemCount: _viewAllController.viewAllResultProducts.length,
                    itemBuilder: (context,index){
                      final product = _viewAllController.viewAllResultProducts[index];
                      if(product.requirePoint! > 0){
                        return ViewAllRewardProductWidget(product: product);
                      }
                      return ViewAllNormalProductWidget(product: product);
                    },
                    );
                }
              ),
              ),
          ],
        ),
      ),  
    );
  }
}