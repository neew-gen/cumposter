import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';
import 'package:get/get.dart';

class PostponedAddScreenImageCheckbox extends StatefulWidget {
  final int _index;

  PostponedAddScreenImageCheckbox(this._index);
  @override
  _State createState() => _State();
}

class _State extends State<PostponedAddScreenImageCheckbox> {
  final PostponedAddOptionsController _postponedAddOptionsController =
      Get.put(PostponedAddOptionsController());
  final PostponedCreateController _postponedCreateController =
      Get.put(PostponedCreateController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _checkboxValue = _postponedAddOptionsController.imageCheckboxList[widget._index];
    return Checkbox(
      value: _checkboxValue,
      onChanged: (_) {
        _checkboxValue = !_checkboxValue;
        setState(() {
        });
        _postponedAddOptionsController.updateImageCheckbox(
            widget._index, _checkboxValue);
        _postponedCreateController.fetchCanCreate();
      },
    );
  }
}
