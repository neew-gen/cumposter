import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/images_from_gallery.dart';
import 'package:get/get.dart';

import 'image.dart';

class PostponedAddScreenImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ImagesFromGalleryController _imagesFromGalleryController =
        Get.put(ImagesFromGalleryController());

    _imagesFromGalleryController.fetchImagesFromGallery();

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
            for (int i = 0;
                i < _imagesFromGalleryController.imageList.length;
                i++)
              PostponedAddScreenImage(
                i,
              ),
          ],
        ));
  }
}
