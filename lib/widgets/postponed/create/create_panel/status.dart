import 'package:flutter/material.dart';

class PostponedCreatePanelStatus extends StatelessWidget {
  final _canCreate;
  PostponedCreatePanelStatus(this._canCreate);

  _buildStatusMessages(canCreate) {
    if (canCreate['messages'].length > 0) {
      return Column(
        children: [
          for (var message in canCreate['messages'])
            Text(
              message,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    // if ()
    return _buildStatusMessages(_canCreate);
  }
}
