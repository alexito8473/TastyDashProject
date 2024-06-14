import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../models/Food.dart';
import 'Constant.dart';

import 'package:flutter/material.dart';

class LoadImageInCache {
  // Preload application-specific images into the Flutter cache
  static Future<void> loadImagesApplication(BuildContext context) async {
    await precacheImage(
        const AssetImage(Constant.PATH_IMAGE_SCRREN_SETTING), context);
    await precacheImage(
        const AssetImage(Constant.PATH_IMAGE_BANNER_LETTER), context);
    await precacheImage(
        const AssetImage(Constant.PATH_IMAGE_BANNER_MEAT), context);
    await precacheImage(
        const AssetImage(Constant.PATH_IMAGE_SCRREN_LOGIN), context);
    await precacheImage(
        const AssetImage(Constant.PATH_IMAGE_SCRREN_PAGE_FOOD), context);
    await precacheImage(
        const AssetImage(Constant.PATH_IMAGE_BANNER_SPECIAL), context);
  }

  // Preload images from a list of Food objects into the Flutter cache
  static Future<void> loadImagesListFood(
      BuildContext context, List<Food> listFood) async {
    for (int i = 0; i < listFood.length; i++) {
      await precacheImage(
          CachedNetworkImageProvider(listFood[i].pathImage), context);
    }
  }
}

