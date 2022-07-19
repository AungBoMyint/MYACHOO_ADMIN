import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          "",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // centerTitle: true,
        actions: [
          // InkWell(
          //   onTap: () {
          //     ///TODO
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          //     padding: EdgeInsets.only(left: 10, right: 10),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(7),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey[200]!,
          //             spreadRadius: 1,
          //             offset: Offset(0, 1),
          //           )
          //         ]),
          //     child: Icon(
          //       Icons.search,
          //       color: Colors.black,
          //     ),
          //   ),
          // )
          Container(
            width: MediaQuery.of(context).size.width * 0.67,
            height: 50,
            child: TextField(
              autofocus: true,
              onChanged: controller.onSearch,
              onSubmitted: controller.searchItem,
              decoration: InputDecoration(
                hintText: "Search...",
                // border: OutlineInputBorder(),
              ),
            ),
          ),

          ElevatedButton(
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
              size: 20,
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(
          //     top: 7,
          //     bottom: 10,
          //     right: 7,
          //   ),
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(Colors.white),
          //       overlayColor: MaterialStateProperty.all(Colors.black12),
          //     ),
          //     onPressed: () async {
          //       try {
          //         await launch('https://m.me/begoniazue');
          //       } catch (e) {
          //         print(e);
          //       }
          //     },
          //     child: FaIcon(
          //       FontAwesomeIcons.facebookMessenger,
          //       color: Colors.blue,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Obx(() {
        return controller.searchitems.isNotEmpty
            ? StaggeredGridView.countBuilder(
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemCount: controller.searchitems.length,
                itemBuilder: (_, i) => Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setSelectedItem(controller.searchitems[i]);
                        Get.toNamed(detailScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: controller.searchitems[i].photo1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.searchitems[i].photo1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20, right: 20),
                                      child: Text(
                                        controller.searchitems[i].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 30,
                                          right: 20),
                                      child: Text(
                                        "${controller.searchitems[i].price} Kyats",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "လိုချင်တဲ့ဖိနပ်အမည်ကို ရှာဖွေနိုင်ပါသည်",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
      }),
    );
  }
}
