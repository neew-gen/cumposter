import 'package:flutter/material.dart';
import 'package:cumposter/controllers/options/debug.dart';
import 'package:get/get.dart';

import 'debug_item.dart';

class DebugErrors extends GetWidget<DebugController> {
  @override
  Widget build(context) {
    return Obx(
      () => Column(children: [
        Row(
          children: [
            Text('Ошибки'),
            TextButton(
              onPressed: () {
                controller.clearDebugErrors();
              },
              child: Text('Очистить'),
            ),
          ],
        ),
        for (var errorItem in controller.debugErrors) DebugItem(errorItem),
      ]),
    );
  }
}
