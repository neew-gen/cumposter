import 'package:cumposter/providers/firebase/unsubscribers/unsubscribers.dart';
import 'package:get/get.dart';
import 'package:cumposter/models/managed_groups_model.dart';

class UnsubscribersController extends GetxController {
  static UnsubscribersController get to => Get.find();

  var unsubscribers = [].obs;
  Future<void> fetchUnsubscribers() async {
    unsubscribers.value = await UnsubscribersProvider().fetch();
  }

  static initialBinding() {
    Get.put<UnsubscribersController>(UnsubscribersController(),
        permanent: true);
  }
}
