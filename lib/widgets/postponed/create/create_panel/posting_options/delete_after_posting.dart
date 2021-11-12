import 'package:cumposter/controllers/postponed/create/options.dart';
import 'package:flutter/material.dart';

class DeleteAfterPostingCheckbox extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DeleteAfterPostingCheckbox> {
  bool _checkboxValue = false;
  @override
  void initState() {
    // _checkboxValue = PostponedCreateOptionsController.to.isShowOptions.value;
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _checkboxValue = PostponedCreateOptionsController.to.isShowOptions.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Показывать настройки записи'),
        Checkbox(
          value: _checkboxValue,
          onChanged: (_) {
            setState(() {
              _checkboxValue = !_checkboxValue;
            });
            PostponedCreateOptionsController.to.updateShowOptions(_checkboxValue);
          },
        )
      ],
    );
  }
}
