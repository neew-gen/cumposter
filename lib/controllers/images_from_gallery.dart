import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagesFromGalleryController extends GetxController {
  var imageList = [].obs;
  var entityList = [].obs;

  Future fetchImagesFromGallery() async {
    if (await Permission.storage.request().isGranted) {
      var downloadsPath = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
      var dataImageList = Directory(downloadsPath).listSync();
      imageList.value = dataImageList;
    }
    // await _requestPerms();
    // if (await Permission.storage.isGranted && await Permission.manageExternalStorage.isGranted) {
    //   var downloadsPath = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    //   var dataImageList = Directory(downloadsPath).listSync();
    //   imageList.value = dataImageList;
    // }
    // var result = await PhotoManager.requestPermissionExtend();
    // if (result.isAuth) {
      // List<AssetPathEntity> list =
      //     await PhotoManager.getAssetPathList();
      // print(list);
      // AssetPathEntity data = list[0];
      // List<AssetEntity> dataEntityList = await data.assetList;
      // var dataImageList = [];
      // for (var entity in dataEntityList) {
      //   entityList.add(entity);
      //   var image = await entity.file;
      //   dataImageList.add(image);
      // }
    // }
  }

  _requestPerms() async {
    Map<Permission, PermissionStatus> statuses = await
    [
      Permission.storage,
      Permission.manageExternalStorage
    ].request();
    return statuses;
  }
}
