import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../models/Food.dart';
import 'Constant.dart';

class LoadImageInCache {
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

  static Future<void> loadImagesListFood(
      BuildContext context, List<Food> listFood) async {
    for (int i = 0; i < listFood.length; i++) {
      await precacheImage(
          CachedNetworkImageProvider(listFood[i].pathImage), context);
    }
  }
}
