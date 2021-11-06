import 'package:cumposter/controllers/unsubscribers/unsubscribers.dart';
import 'package:flutter/material.dart';
import 'package:cumposter/controllers/welcome.dart';

class UnsubscribersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UnsubscribersController.to.fetchUnsubscribers();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('123'),
          ],
        ),
      ),
    );
  }
}
