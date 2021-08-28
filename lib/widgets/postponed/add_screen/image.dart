import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/images_from_gallery.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';
import 'package:get/get.dart';

import 'image_checkbox.dart';

class PostponedAddScreenImage extends GetWidget<ImagesFromGalleryController> {
  final _index;
  PostponedAddScreenImage(this._index);

  @override
  Widget build(BuildContext context) {
    PostponedAddOptionsController.to.fetchImageCheckboxList();
    // return GetBuilder<ImagesFromGalleryController>(
    //   // init: ImagesFromGalleryController(),
    //   builder: (value) =>
    //       Stack(alignment: Alignment.bottomCenter, children: <Widget>[
    //     Image.file(ImagesFromGalleryController.to.imageList[_index]),
    //     Align(
    //       alignment: Alignment.topRight,
    //       child: Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: PostponedAddScreenImageCheckbox(_index),
    //       ),
    //     ),
    //   ]),
    // );
    return Obx(
      () => Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        Image.file(controller.imageList[_index]),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: PostponedAddScreenImageCheckbox(_index),
          ),
        ),
      ]),
    );
  }
}

// class PostponedAddScreenImage extends StatefulWidget {
//   final _index;
//
//   PostponedAddScreenImage(this._index);
//   @override
//   _PostponedAddScreenImageState createState() =>
//       _PostponedAddScreenImageState();
// }
//
// class _PostponedAddScreenImageState extends State<PostponedAddScreenImage> {
//   final ImagesFromGalleryController _imagesFromGalleryController = Get.find();
//   final PostponedAddOptionsController _postponedAddOptionsController =
//       Get.put(PostponedAddOptionsController());
//   final PostponedCreateController _postponedCreateController =
//       Get.put(PostponedCreateController());
//
//   @override
//   void initState() {
//     super.initState();
//     _postponedAddOptionsController.fetchImageCheckboxList();
//   }
//   @override
//   void dispose() {
//     Checkbox
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
//       Image.file(_imagesFromGalleryController.imageList[widget._index]),
//       PostponedAddScreenImageCheckbox(),
//     ]);
//   }
// }
