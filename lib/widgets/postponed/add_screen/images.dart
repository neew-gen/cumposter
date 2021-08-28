import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/images_from_gallery.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/options/debug.dart';

import 'image.dart';

class PostponedAddScreenImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImagesFromGalleryController.to.fetchImagesFromGallery();
    // final ImagesFromGalleryController _imagesFromGalleryController =
    //     Get.put(ImagesFromGalleryController());
    //
    // _imagesFromGalleryController.fetchImagesFromGallery();

    // return GetBuilder<ImagesFromGalleryController>(
    //   init: ImagesFromGalleryController(),
    //   initState: (_) => controller.fetchImagesFromGallery(),
    //   builder: (value) => GridView(
    //     // itemCount: _imagesFromGalleryController.imageList.length,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount:
    //           MediaQuery.of(context).orientation == Orientation.landscape
    //               ? 3
    //               : 2,
    //       crossAxisSpacing: 8,
    //       mainAxisSpacing: 8,
    //       childAspectRatio: (2 / 2),
    //     ),
    //     children: [
    //       for (int i = 0;
    //           i < ImagesFromGalleryController.to.imageList.length;
    //           i++)
    //         PostponedAddScreenImage(
    //           i,
    //         ),
    //     ],
    //   ),
    // );

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
                i < ImagesFromGalleryController.to.imageList.length;
                i++)
              PostponedAddScreenImage(
                i,
              ),
          ],
        ));
  }
}
