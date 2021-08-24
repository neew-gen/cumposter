import 'package:get/get.dart';

import '../../images_from_gallery.dart';

class PostponedAddOptionsController extends GetxController {
  var imageCheckboxList = [].obs;
  void fetchImageCheckboxList() {
    final ImagesFromGalleryController _imagesFromGalleryController = Get.find();

    var imageList = _imagesFromGalleryController.imageList;
    List<bool> checkBoxList = [];
    for (int i = 0; i < imageList.length; i++) {
      checkBoxList.add(false);
    }
    imageCheckboxList.value = checkBoxList;
  }

  void updateImageCheckbox(index, value) {
    imageCheckboxList[index] = value;
  }

  var text = ''.obs;
  void updateText(newValue) async {
    text.value = newValue;
  }

  var deleteImageAfterSave = false.obs;
  void updateDeleteImageAfterSave(newValue) async {
    deleteImageAfterSave = newValue;
  }

  var signed = true.obs;
  void updateSigned(newValue) async {
    signed = newValue;
  }
}
