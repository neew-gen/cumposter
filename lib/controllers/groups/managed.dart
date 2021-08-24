import 'package:get/get.dart';
import 'package:vk_group_admin/utilities/vk/get/get_managed_groups.dart';

class ManagedGroupsController extends GetxController {
  var managedGroups = [].obs;

  void fetchManagedGroups() async {
    var fetchedManagedGroups = await getManagedGroups();
    managedGroups.value = fetchedManagedGroups;
  }
}
