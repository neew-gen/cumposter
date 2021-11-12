import 'package:cumposter/constants/appbar_config.dart';
import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  final String text;

  AppbarTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: appbarFontSize, fontWeight: appbarFontWeight),
    );
  }
}
