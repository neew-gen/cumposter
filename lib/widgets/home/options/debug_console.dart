import 'package:flutter/material.dart';
import 'package:cumposter/controllers/options/debug.dart';
import 'package:get/get.dart';

import 'debug_item.dart';

class DebugConsole extends GetWidget<DebugController> {
  @override
  Widget build(context) {

    return Obx(
      () => Column(children: [
        Row(
          children: [
            Text('Консоль'),
            TextButton(
              onPressed: () {
                controller.clearDebugConsole();
              },
              child: Text('Очистить'),
            ),
          ],
        ),
        for (var consoleItem in controller.debugConsole) DebugItem(consoleItem),
      ]),
    );
  }
}
