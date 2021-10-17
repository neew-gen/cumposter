import 'package:cumposter/controllers/postponed/create/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/create/create.dart';

class PostponedCreatePanelTextField
    extends GetView<PostponedCreateTextController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Form(
            key: controller.optionsFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Текст записи',
                  ),
                  maxLines: 10,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.text.value = value;
                    PostponedCreateController.to.fetchCanCreate();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
