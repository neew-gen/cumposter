import 'package:cumposter/controllers/unsubscribers/unsubscribers.dart';
import 'package:cumposter/widgets/unsubscribers/unsubscribers_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnsubscribersList extends StatelessWidget {
  @override
  Widget build(context) {
    return Obx(
      () => ListView.builder(
        itemCount: UnsubscribersController.to.unsubscribers.length,
        itemBuilder: (BuildContext context, int index) {
          return UnsubscribersItem(
            UnsubscribersController.to.unsubscribers[index],
          );
        },
      ),
    );
  }
}
