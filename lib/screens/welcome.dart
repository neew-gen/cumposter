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
            Image(
              image: AssetImage(
                'assets/images/cumposter_logo.png',
              ),
              width: 200,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'logo by OLEG',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(39, 135, 245, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
