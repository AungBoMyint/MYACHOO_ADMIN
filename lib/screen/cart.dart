import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/widgets/home_appbar/home_app_bar.dart';

import '../../controller/home_controller.dart';
import '../../data/constant.dart';
import '../../data/enum.dart';
import '../../data/township_list.dart';
import '../../model/division.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_checkbox.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final HomeController controller = Get.find();
    controller.updateSubTotal(false); //Make Sure To Update SubTotal

    return Scaffold(
      body: Column(
        children: [
          Obx(
              () =>controller.myCart.length > 0  ? Expanded(
                child: ListView.builder(
                  itemCount: controller.myCart.length,
                  itemBuilder: (_, i) {
                    String photo =
                        controller.getItem(controller.myCart[i].id)!.photo1;

                    return Card(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: photo,
                              // "$baseUrl$itemUrl${controller.getItem(controller.myCart[i].id).photo}/get",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    controller
                                        .getItem(controller.myCart[i].id)
                                        !.name,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                SizedBox(height: 5),
                                if(!(controller.myCart[i].color == null))...[
                                  Text(
                                  "${controller.myCart[i].color}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                ],
                                SizedBox(height: 5),
                                if(!(controller.myCart[i].size == null))...[
                                  Text(
                                  "${controller.myCart[i].size}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                ],
                                SizedBox(height: 5),
                                Text(
                                  "${controller.myCart[i].discountPrice! > 0 ? controller.myCart[i].discountPrice! :
                                  controller.myCart[i].requirePoint! > 0 ? controller.myCart[i].requirePoint! : controller.myCart[i].price}"
                                  "${controller.myCart[i].requirePoint! > 0 ? 'မှတ်' : 'ကျပ်'}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.remove(controller.myCart[i]);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Text(controller.myCart[i].count.toString()),
                                IconButton(
                                  onPressed: () {
                                    controller.addCount(controller.myCart[i]);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ) : const SizedBox(),
            ),

          GetBuilder<HomeController>(builder: (controller) {
            return Container(
              width: double.infinity,
              height: 170,
              child: Card(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ကုန်ပစ္စည်းအတွက် ကျသင့်ငွေ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${controller.subTotal} ကျပ်",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                                   () {
                                    final hasError = controller.firstTimePressedCart.value && 
                                    controller.townShipNameAndFee.isEmpty;
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: hasError ? Colors.red : Colors.white.withOpacity(0),
                                        ),
                                      ),
                            child:  Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  //DropDown TownShip List
                                  Container(
                                    width: 250,
                                    height: 50,
                                    child:
                                        GetBuilder<HomeController>(builder: (controller) {
                                      return InkWell(
                                        onTap: () {
                                          //Show Dialog
                                          showDialog(
                                              barrierColor: Colors.white.withOpacity(0),
                                              context: context,
                                              builder: (context) {
                                                return divisionDialogWidget();
                                              });
                                        },
                                        child: Container(
                                          child: Row(children: [
                                            //Township Name
                                            Expanded(
                                              child: Text(
                                                controller.townShipNameAndFee["townName"] ??
                                                    "မြို့နယ်",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 13
                                                ),
                                              ),
                                            ),
                                            //DropDown Icon
                                            Expanded(
                                                child: Icon(FontAwesomeIcons.angleRight)),


                                          ]),
                                        ),
                                      );
                                    }),
                                  ),
                                  GetBuilder<HomeController>(builder: (controller) {
                                    return Row(
                                      children: [
                                        Text(
                                          controller.townShipNameAndFee.isEmpty
                                              ? "0 ကျပ်"
                                              : " ${controller.townShipNameAndFee["fee"]} ကျပ်",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      margin: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 10,
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(25, 25, 25, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "စုစုပေါင်း ကျသင့်ငွေ   =  ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GetBuilder<HomeController>(builder: (controller) {
                            return Text(
                              controller.townShipNameAndFee.isEmpty
                                  ? "${controller.subTotal}"
                                  : "${controller.subTotal + controller.townShipNameAndFee["fee"]} ကျပ်",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          Container(
            width: double.infinity,
            height: 45,
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(homeIndicatorColor),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                if (controller.checkToAcceptOrder()) {
                  //TODO: SHOW DIALOG TO CHOOSE OPTION,THEN GO TO CHECKOUT
                  Get.defaultDialog(
                    backgroundColor: Colors.white70,
                    titlePadding: EdgeInsets.all(8),
                    contentPadding: EdgeInsets.all(0),
                    title: "ရွေးချယ်ရန်",
                    content: PaymentOptionContent(),
                    barrierDismissible: false,
                    confirm: nextButton(),
                  );
                  //Get.toNamed(checkOutScreen);
                } 
              },
              child: Text("Order တင်ရန် နှိပ်ပါ",
              style: TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
              ),),
            ),
          )
        ],
      ),
    );
  }

  Widget divisionDialogWidget() {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.center,
        child: GetBuilder<HomeController>(builder: (controller) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(),
                bottom: BorderSide(),
                left: BorderSide(),
                right: BorderSide(),
              ),
            ),
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: divisionList.length,
                itemBuilder: (context, divisionIndex) {
                  return MouseRegion(
                    onHover: (event) {
                      controller.changeMouseIndex(divisionIndex);
                      showDialog(
                        context: context,
                        barrierColor: Colors.white.withOpacity(0),
                        builder: (context) {
                          return townShipDialog(
                              division: divisionList[divisionIndex]);
                        },
                      );
                    },
                    onExit: (event) {
                      // controller
                      //   .changeMouseIndex(0);
                      Navigator.of(context).pop();
                    },
                    child: AnimatedContainer(
                      color: controller.mouseIndex == divisionIndex
                          ? Colors.orangeAccent
                          : Colors.white,
                      duration: const Duration(milliseconds: 200),
                      child:
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                        //Text
                        Text(divisionList[divisionIndex].name, style: TextStyle(
                          color: controller.mouseIndex == divisionIndex
                        ? Colors.white
                            : Colors.black,fontSize: 16,),),
                        SizedBox(width: 10),
                        Icon(FontAwesomeIcons.angleRight),
                      ]),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget townShipDialog({required Division division}) {
    HomeController _controller = Get.find();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 400,
        height: MediaQuery.of(Get.context!).size.height,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(),
            bottom: BorderSide(),
            left: BorderSide(),
            right: BorderSide(),
          ),
          color: Colors.white,
        ),
        child: ListView(
          children: division.townShipMap.entries.map((map) {
            return SizedBox(
              height: map.value.length * 50,
              child: ListView.builder(
                  primary: false,
                  itemCount: map.value.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        _controller.setTownShipNameAndShip(
                          name: map.value[index],
                          fee: map.key,
                        );
                        //Pop this dialog
                        Get.back();
                        Get.back();
                      },
                      child: Text(map.value[index],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                      ),
                    );
                  }),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PaymentOptionContent extends StatelessWidget {
  const PaymentOptionContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomCheckBox(
          height: 50,
          options: PaymentOptions.CashOnDelivery,
          icon: FontAwesomeIcons.truck,
          iconColor: Colors.amber,
          text: "ပစ္စည်း ရောက်မှ ငွေချေမယ်",
        ),
        SizedBox(height: 5),
        CustomCheckBox(
          height: 50,
          options: PaymentOptions.PrePay,
          icon: FontAwesomeIcons.moneyBill,
          iconColor: Colors.blue,
          text: "ငွေကြိုလွှဲမယ်",
        ),
      ]),
    );
  }
}

Widget nextButton() {
  HomeController controller = Get.find();
  return //Next
      Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: TextButton(
      onPressed: () {
        if (controller.paymentOptions != PaymentOptions.None) {
          //Go To CheckOut Screen
          Navigator.of(Get.context!).pop();
          Get.toNamed(checkOutScreen);
        }
      },
      child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 16)),
    ),
  );
}
