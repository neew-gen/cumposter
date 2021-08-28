import 'package:flutter/material.dart';

class PostingDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Создание записи'),
      content: Text('Идет создание записи.'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Отменить'),
        ),
      ],
    );
  }
}
