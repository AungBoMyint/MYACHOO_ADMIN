import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/constant.dart';
import '../../routes/routes.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget{
  const HomeAppBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          "မြခြူး Mya Choo",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
            // fontStyle: FontStyle.italic,
            wordSpacing: 2,
            letterSpacing: 1,
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

          SizedBox(
            width: 20,
          ),

          // SizedBox(
          //   width: 45,
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //       alignment: Alignment.center,
          //       backgroundColor: MaterialStateProperty.all(Colors.white),
          //       elevation: MaterialStateProperty.resolveWith<double>(
          //         // As you said you dont need elevation. I'm returning 0 in both case
          //             (Set<MaterialState> states) {
          //           if (states.contains(MaterialState.disabled)) {
          //             return 0;
          //           }
          //           return 0; // Defer to the widget's default.
          //         },
          //       ),
          //     ),
          //     onPressed: ()  {
          //       Get.toNamed(cartUrl);
          //     },
          //     child: FaIcon(
          //       FontAwesomeIcons.shoppingBasket,
          //       color: Colors.black,
          //       size: 23,
          //     ),
          //   ),
          // ),


        ],
      );
  }

  @override
  Size get preferredSize => Size(double.infinity, 65);
}