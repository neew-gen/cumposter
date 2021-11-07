import 'package:get/get.dart';
import 'package:cumposter/models/managed_groups_model.dart';
import 'package:cumposter/utilities/vk/get/get_managed_groups.dart';

class ManagedGroupsController extends GetxController {
  static ManagedGroupsController get to => Get.find();
  RxList<ManagedGroup> managedGroups = <ManagedGroup>[].obs;

  void fetchManagedGroups() async {
    List<ManagedGroup>? fetchedManagedGroups = await getManagedGroups();
    managedGroups.value = fetchedManagedGroups!;
  }
}
