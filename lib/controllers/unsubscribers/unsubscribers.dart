import 'package:cumposter/providers/firebase/unsubscribers/unsubscribers.dart';
import 'package:get/get.dart';
import 'package:cumposter/models/managed_groups_model.dart';

class UnsubscribersController extends GetxController {
  static UnsubscribersController get to => Get.find();

  var unsubscribers = [].obs;
  void fetchUnsubscribers() {
    UnsubscribersProvider().fetch();
    // currentGroup.value = groupInfo;
  }

  static initialBinding() {
    Get.put<UnsubscribersController>(UnsubscribersController(),
        permanent: true);
  }
}
