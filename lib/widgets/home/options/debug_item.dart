import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DebugItem extends StatelessWidget {
  final _debugItem;

  DebugItem(this._debugItem);

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _debugItem['date'],
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      _debugItem['from'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              child: Text(
                _debugItem['text'],
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
