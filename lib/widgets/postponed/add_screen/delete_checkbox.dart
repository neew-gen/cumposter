import 'package:flutter/material.dart';

class PostponedAddDeleteCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Удаляет картинку после создания записи!"),
        // Checkbox(
        //   value: _deleteImageAfterSaving,
        //   onChanged: (_) {
        //     setState(() {
        //       _deleteImageAfterSaving = !_deleteImageAfterSaving;
        //     });
        //     _changeDeleteImageAfterSaving();
        //   },
        // ),
      ],
    );
  }
}
