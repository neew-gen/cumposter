import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';

class ErrorDialog extends GetWidget<PostponedCreateController> {
  _getErrorText () {
    var errorCode = controller.errorCode.value;
    if (errorCode == 214) {
      return 'На это время уже есть запись, пожалуйста, измените время.';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ошибка'),
      content: Text(_getErrorText()),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('OK'),
        ),
      ],
    );
  }
}
