import 'package:cumposter/constants/appbar_config.dart';
import 'package:flutter/material.dart';
import 'package:cumposter/widgets/options/debug_console.dart';
import 'package:cumposter/widgets/options/debug_errors.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Настройки приложения'
        ),
      ),
      body: ListView(
        children: [Text('Тут что-то будет.')],
      ),
    );
  }
}
