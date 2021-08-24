import 'package:get/get.dart';

class CurrentGroupController extends GetxController {
  var currentGroup = {}.obs;

  void setCurrentGroup(groupInfo) async {
    currentGroup.value = groupInfo;
  }
}