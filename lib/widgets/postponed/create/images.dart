import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/create/images.dart';

import 'image.dart';

class PostponedCreateScreenImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostponedCreateImagesController.to.fetchImagesFromGallery();

    return Obx(() => GridView(
          // itemCount: _imagesFromGalleryController.imageList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 3
                    : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: (2 / 2),
          ),
          children: [
            for (var image in PostponedCreateImagesController.to.imagesList)
              PostponedAddScreenImage(
                image,
              ),
          ],
        ));
  }
}
