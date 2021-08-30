import 'package:flutter/material.dart';

import 'image_checkbox.dart';

class PostponedAddScreenImage extends StatelessWidget {
  final _imageObject;
  PostponedAddScreenImage(this._imageObject);

  @override
  Widget build(BuildContext context) {
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
    return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      Image.file(
        _imageObject.imageFile,
      ),
      // Obx(
      //   () => Image.file(
      //     ImagesFromGalleryController.to.imageList[_index],
      //   ),
      // ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: PostponedAddScreenImageCheckbox(
            _imageObject.id,
            _imageObject.isChecked,
          ),
        ),
      ),
    ]);
    // return Obx(
    //   () => Stack(alignment: Alignment.bottomCenter, children: <Widget>[
    //     Image.file(ImagesFromGalleryController.to.imageList[_index]),
    //     Align(
    //       alignment: Alignment.topRight,
    //       child: Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: PostponedAddScreenImageCheckbox(
    //           _index,
    //           PostponedAddOptionsController.to.imageCheckboxList[_index],
    //         ),
    //       ),
    //     ),
    //   ]),
    // );
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
