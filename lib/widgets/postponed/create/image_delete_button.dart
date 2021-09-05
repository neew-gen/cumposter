import 'package:cumposter/controllers/postponed/create/images.dart';
import 'package:cumposter/utilities/files/images/delete_gallery_image.dart';
import 'package:flutter/material.dart';

class ImageDeleteButton extends StatelessWidget {
  final _imageFile;
  ImageDeleteButton(this._imageFile);
  _deleteImage() {
    deleteGalleryImage(_imageFile);
    PostponedCreateImagesController.to.fetchImagesFromGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: _deleteImage,
          icon: Icon(
            Icons.delete_outline,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
