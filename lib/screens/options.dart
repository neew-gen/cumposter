import 'package:flutter/material.dart';
import 'package:vk_group_admin/widgets/options/debug_console.dart';
import 'package:vk_group_admin/widgets/options/debug_errors.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки приложения'),
      ),
      body: ListView(
        children: [
          DebugConsole(),
          DebugErrors(),
        ],
      ),
    );
  }
}
