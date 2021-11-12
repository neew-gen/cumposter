import 'package:cumposter/controllers/unsubscribers/unsubscribers.dart';
import 'package:cumposter/widgets/unsubscribers/unsubscribers_list.dart';
import 'package:flutter/material.dart';

class UnsubscribersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UnsubscribersController.to.fetchUnsubscribers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Кто отписался'),
        automaticallyImplyLeading: false,
      ),
      body: UnsubscribersList(),
    );
  }
}
