import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/options/debug.dart';
import 'package:get/get.dart';

import 'debug_item.dart';

class DebugConsole extends GetWidget<DebugController> {
  @override
  Widget build(context) {
    // controller.updateDebugConsole(123);
    // final DebugController _debugController = Get.find(tag: 'DebugController');
    // print(_debugController.debugConsole);

    // return Column(children: [
    //   Row(
    //     children: [
    //       Text('Консоль'),
    //     ],
    //   ),
    //   for (var consoleItem in controller.debugConsole) DebugItem(consoleItem),
    // ]);
    // return GetBuilder<DebugController>(
    //   builder: (value) => Column(children: [
    //     Row(
    //       children: [
    //         Text('Консоль'),
    //       ],
    //     ),
    //     TextButton(onPressed: () {
    //     }, child: Text('+')),
    //     for (var consoleItem in DebugController.to.debugConsole)
    //       DebugItem(consoleItem),
    //   ]),
    // );

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
