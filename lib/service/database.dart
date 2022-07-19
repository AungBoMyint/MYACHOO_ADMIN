import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/model/purchase_item.dart';
import 'package:uuid/uuid.dart';

import '../controller/home_controller.dart';
import '../model/real_purchase.dart';
import 'api.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> watch(String collectionPath) =>
      _firebaseFirestore.collection(collectionPath).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> watchOrder(
          String collectionPath) =>
      _firebaseFirestore
          .collection(collectionPath)
          .orderBy('dateTime', descending: true)
          .snapshots();

  Future<DocumentSnapshot<Map<String, dynamic>>> read(
    String collectionPath, {
    String? path,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).get();

  Future<void> write(
    String collectionPath, {
    String? path,
    required Map<String, dynamic> data,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).set(data);

  //Write PurchaseData
  Future<void> writePurchaseData(PurchaseModel model) async {
    List<PurchaseItem> rewardProductList = model.items.where((element) => element.requirePoint! > 0)
                  .toList();
    if (!(model.bankSlipImage == null)) {
      final file = File(model.bankSlipImage!);
      debugPrint("**************${model.bankSlipImage!}");
      try {
        await _firebaseStorage
            .ref()
            .child("bankSlip/${Uuid().v1()}")
            .putFile(file)
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final purchaseModel = model.copyWith(bankSlipImage: value).toJson();
            //Then we set this user into Firestore
            await _firebaseFirestore
                .collection(purchaseCollection)
                .doc(model.id)
                .set(purchaseModel).then((value) async{

                   try {
                Api.sendPush(
                        "အော်ဒါတင်ခြင်း",
                        "🧑အမည်:${model.name}\n"
                            "🏠လိပ်စာ: ${model.address}\n"
                            "✍အီးမေးလ်: ${model.email}")
                    .then((value) =>
                        debugPrint("*****Success push notification*****"));
              } catch (e) {
                debugPrint("********Push Failed: $e**");
              }  
              
                  int totalPay = 0;
                  for (var item in model.items) {
                    if(item.discountPrice! > 0){
                      totalPay += item.count * item.discountPrice!;
                    }else if(!(item.requirePoint! > 0)){
                      totalPay += item.count * item.price;
                    }
                    
                  }
                  debugPrint("*******Totalpay: $totalPay********");
                  await increaseCurrentUserPoint(
                      int.parse("${totalPay / 100}".split('.').first));
                      if (rewardProductList.isNotEmpty) {
            int totalPoints = 0;
            for (var item in rewardProductList) {
              totalPoints += item.requirePoint! * item.count;
            }
            try {
              await reduceCurrentUserPoint(totalPoints);
            } catch (e) {
              debugPrint("*****ReduceFailed: $e");
            }
          }
                });
          });
        });
      } on FirebaseException catch (e) {
        debugPrint("*******Image Upload Error $e******");
      }
    }else{
      try {
        await _firebaseFirestore
                .collection(purchaseCollection)
                .doc(model.id)
                .set(model.toJson()).then((value) async{
                   try {
                Api.sendPush(
                        "အော်ဒါတင်ခြင်း",
                        "🧑အမည်:${model.name}\n"
                            "🏠လိပ်စာ: ${model.address}\n"
                            "✍အီးမေးလ်: ${model.email}")
                    .then((value) =>
                        debugPrint("*****Success push notification*****"));
              } catch (e) {
                debugPrint("********Push Failed: $e**");
              }  
              
                  int totalPay = 0;
                  for (var item in model.items) {
                    if(item.discountPrice! > 0){
                      totalPay += item.count * item.discountPrice!;
                      
                    }else if(!(item.requirePoint! > 0)){
                      totalPay += item.count * item.price;
                    }
                    
                  }
                  debugPrint("*******Totalpay: $totalPay********");
                  await increaseCurrentUserPoint(
                      int.parse("${totalPay / 100}".split('.').first));
                      if (rewardProductList.isNotEmpty) {
            int totalPoints = 0;
            for (var item in rewardProductList) {
              totalPoints += item.requirePoint! * item.count;
            }
            try {
              await reduceCurrentUserPoint(totalPoints);
            } catch (e) {
              debugPrint("*****ReduceFailed: $e");
            }
          }
                });
      } on FirebaseException catch (e) {
        debugPrint("*******Image Upload Error $e******");
      }
    }
  }  
    ////////////////////////
    /* if (!(model.bankSlipImage == null)) {
      //if image is not empty or null,we need to store Image FILE
      final file = File(model.bankSlipImage!);
      try {
        await _firebaseStorage
            .ref()
            .child("bankSlipImage/${Uuid().v4}")
            .putFile(file)
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((image) {
            debugPrint("***********get download image url**************");
            model = model.copyWith(bankSlipImage: image);
            _firebaseFirestore
                .collection(purchaseCollection)
                .doc()
                .set(model.toJson());
          });
        });
      } catch (e) {
        debugPrint(
            "**************PurchaseSubmitError and BankSlip $e************");
      }
    }*/


  Future<void> update(
    String collectionPath, {
    required String path,
    required Map<String, dynamic> data,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).update(data);

  Future<void> delete(
    String collectionPath, {
    required String path,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).delete();

//--------------Functions For Reward System------------------------------//
  //Give Point Depend on Order Product Count
  Future<void> increaseCurrentUserPoint(int increasePoint) async {
    HomeController _controller = Get.find();
    _firebaseFirestore.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(_firebaseFirestore
            .collection(adminUserCollection)
            .doc(_controller.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;
        debugPrint("*********Point in increase current user point function:$increasePoint");
        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint + increasePoint,
          },
        );
      },
    );
  }

  //Reduce Point Depend on Order Product Count
  Future<void> reduceCurrentUserPoint(int reducePoint) async {
    HomeController _controller = Get.find();
    _firebaseFirestore.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(_firebaseFirestore
            .collection(adminUserCollection)
            .doc(_controller.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;

        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint - reducePoint,
          },
        );
      },
    );
  }

//-----------------------------------------------------------------------//      
}

