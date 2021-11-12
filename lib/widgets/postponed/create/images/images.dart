import 'package:cumposter/controllers/postponed/create/images/images_path.dart';
import 'package:cumposter/screens/postponed/postponed_create/create_image_directory.dart';
import 'package:cumposter/utilities/files/directories/path.dart';
import 'package:cumposter/utilities/text/trim_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/create/images/images.dart';

import 'image.dart';

class PostponedCreateScreenImages extends StatelessWidget {
  _getImagesPathText(path) {
    var trimmedPath = getLastItemOfPath(path);
    return 'Имя папки: $trimmedPath';
  }

  @override
  Widget build(BuildContext context) {
    PostponedCreateImagesController.to.fetchImagesFromGallery();

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  _getImagesPathText(
                      PostponedCreateImagesPathController.to.imagesPath.value),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => PostponedCreateImageDirectory());
                },
                child: Text('Изменить'),
              ),
            ],
          ),
          Expanded(
            child: Obx(() => GridView(
                  // itemCount: _imagesFromGalleryController.imageList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 3
                        : 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: (2 / 2),
                  ),
                  children: [
                    for (var image
                        in PostponedCreateImagesController.to.imagesList)
                      PostponedAddScreenImage(
                        image,
                      ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
