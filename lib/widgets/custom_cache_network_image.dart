import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget customCacheNetworkImage(String imageUrl){
  return CachedNetworkImage(
                progressIndicatorBuilder: (context, url, status) {
                  return Shimmer.fromColors(
    baseColor: Colors.red,
    highlightColor: Colors.yellow,
    child: Text(
      'Shimmer',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40.0,
        fontWeight:
        FontWeight.bold,
      ),
    ),
  );
                },
                errorWidget: (context, url, whatever) {
                  return const Text("Image not available");
                },
                imageUrl:
                    imageUrl,
                fit: BoxFit.fill,
              );
}