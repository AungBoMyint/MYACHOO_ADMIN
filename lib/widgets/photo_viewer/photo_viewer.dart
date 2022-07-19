
  //PhotoViewer
  import 'package:flutter/material.dart';
  import 'package:photo_view/photo_view.dart';


Widget photoViewer({required String heroTags}) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PhotoView(
          imageProvider: NetworkImage(heroTags),
          loadingBuilder: (context, progress) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: const CircularProgressIndicator(),
            ),
          ),
          backgroundDecoration:
              BoxDecoration(color: Colors.white.withOpacity(0)),
          gaplessPlayback: false,
          //customSize: MediaQuery.of(context).size,
          heroAttributes: PhotoViewHeroAttributes(
            tag: heroTags,
            transitionOnUserGestures: true,
          ),
          //scaleStateChangedCallback: this.onScaleStateChanged,
          enableRotation: true,
          //controller:  controller,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 3,
          initialScale: PhotoViewComputedScale.contained,
          basePosition: Alignment.center,
          //scaleStateCycle: scaleStateCycle
        ),
      ),
    );
  }