import 'package:flutter/material.dart';


class DebugItem extends StatelessWidget {
  final _debugItem;

  DebugItem(this._debugItem);

  @override
  Widget build(context) {
    return Card(
      child: ListTile(
        leading: Text(_debugItem['date']),
        title: Text(
          _debugItem['text'],
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
