import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/screen/shop.dart';
import 'package:kozarni_ecome/screen/view/favourite.dart';
import 'package:kozarni_ecome/screen/view/hot.dart';
import 'package:kozarni_ecome/screen/view/home.dart';
import 'package:kozarni_ecome/widgets/bottom_nav.dart';
import 'package:kozarni_ecome/widgets/home_appbar/home_app_bar.dart';

import '../routes/routes.dart';
import 'cart.dart';
import 'view/profile.dart';

List<Widget> _template = [
  HomeView(),
  Shop(),
  // HotView(),
  // BrandView(),
  CartView(),
  FavouriteView(),
  ProfileView(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   @override
  void initState() {
    super.initState();
    setUpForegroundNotification();
    // notitficationPermission();
    // initMessaging();
  }
  selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.toNamed(purchaseScreen);
}

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Get.toNamed(payload!);
            },
          )
        ],
      ),
    );
  }

  Future<void> setUpForegroundNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    //Initialization Setting
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    //Initialization
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Channel ID: 1',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('noti'),
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: IOSNotificationDetails(sound: "noti.mp3"));
    //LIsten Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final noti = message.notification!;
      await flutterLocalNotificationsPlugin.show(
          0, //ID
          noti.title,
          noti.body,
          platformChannelSpecifics,
          payload: message.data["route"]);
      debugPrint("**********Push Reach******");
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: Obx(
        () => _template[controller.navIndex.value],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
