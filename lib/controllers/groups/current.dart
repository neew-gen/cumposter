import 'package:get/get.dart';
import 'package:cumposter/models/managed_groups_model.dart';

class CurrentGroupController extends GetxController {
  static CurrentGroupController get to => Get.find();

  Rx<ManagedGroup> currentGroup = ManagedGroup('', '', '', 0).obs;
  void setCurrentGroup(ManagedGroup groupInfo) {
    currentGroup.value = groupInfo;
  }
}
