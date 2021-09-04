import 'package:get/get.dart';
import 'package:vk_group_admin/models/managed_groups_model.dart';

class CurrentGroupController extends GetxController {
  static CurrentGroupController get to => Get.find();

  Rx<ManagedGroup> currentGroup = ManagedGroup('', '', '').obs;
  void setCurrentGroup(ManagedGroup groupInfo) {
    currentGroup.value = groupInfo;
  }
}
