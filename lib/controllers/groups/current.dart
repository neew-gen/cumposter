import 'package:get/get.dart';

class CurrentGroupController extends GetxController {
  static CurrentGroupController get to => Get.find();

  var currentGroup = {}.obs;
  void setCurrentGroup(groupInfo) async {
    currentGroup.value = groupInfo;
  }
}