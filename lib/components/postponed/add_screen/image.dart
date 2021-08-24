import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/images_from_gallery.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';
import 'package:get/get.dart';

class PostponedAddScreenImage extends StatefulWidget {
  final _index;

  PostponedAddScreenImage(this._index);
  @override
  _PostponedAddScreenImageState createState() =>
      _PostponedAddScreenImageState();
}

class _PostponedAddScreenImageState extends State<PostponedAddScreenImage> {
  bool _checkboxValue = false;
  final ImagesFromGalleryController _imagesFromGalleryController = Get.find();
  final PostponedAddOptionsController _postponedAddOptionsController =
      Get.put(PostponedAddOptionsController());
  final PostponedCreateController _postponedCreateController =
  Get.put(PostponedCreateController());

  @override
  void initState() {
    super.initState();
    _postponedAddOptionsController
        .fetchImageCheckboxList();
    _checkboxValue = _postponedAddOptionsController.imageCheckboxList[widget._index];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      Image.file(_imagesFromGalleryController.imageList[widget._index]),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Checkbox(
            value: _checkboxValue,
            onChanged: (_) {
              setState(() {
                _checkboxValue = !_checkboxValue;
              });
              _postponedAddOptionsController.updateImageCheckbox(
                  widget._index, _checkboxValue);
              _postponedCreateController.fetchCanCreate();
            },
          ),
        ),
      ),
    ]);
  }
}
