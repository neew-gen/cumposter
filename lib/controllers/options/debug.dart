import 'package:get/get.dart';

class DebugController extends GetxController {
  var debugConsole = [].obs;
  var debugErrors = [].obs;

  static DebugController get to => Get.find();

  updateDebugConsole(input) {
    var inputToString = input.toString();
    var date = DateTime.now().toLocal().toString();
    debugConsole.add({
      'date': date,
      'text': inputToString,
    });
  }
  clearDebugConsole() {
    debugConsole.value = [];
  }

  updateDebugErrors(input) {
    var inputToString = input.toString();
    var date = DateTime.now().toLocal().toString();
    debugErrors.add({
      'date': date,
      'text': inputToString,
    });
  }
  clearDebugErrors() {
    debugErrors.value = [];
  }
}
