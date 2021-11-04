import 'package:flutter/material.dart';

class PostText extends StatelessWidget {
  final text;
  PostText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        // style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
    );
  }
}