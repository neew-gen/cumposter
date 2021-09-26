import 'package:cumposter/controllers/postponed/create/options.dart';
import 'package:flutter/material.dart';

class ShowOptionsSwitch extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ShowOptionsSwitch> {
  var _switchValue = false;
  @override
  void initState() {
    print('initState');
    _switchValue = PostponedCreateOptionsController.to.isShowOptions.value;
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
    _switchValue = PostponedCreateOptionsController.to.isShowOptions.value;
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
        Switch(
          value: _switchValue,
          onChanged: (_) {
            setState(() {
              _switchValue = !_switchValue;
            });
            print(_switchValue);
            PostponedCreateOptionsController.to.updateShowOptions(_switchValue);
          },
        )
      ],
    );
  }
}
