import 'package:flutter/material.dart';
import 'package:cumposter/controllers/welcome.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WelcomeController.to.checkCredentials();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "VK Group Admin",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
