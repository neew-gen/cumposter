import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/enums/post_enums.dart';
import 'package:vk_group_admin/widgets/postponed/add_screen/posting_dialog.dart';

import 'error_dialog.dart';

class PostponedAddScreenStatus extends StatelessWidget {
  final _canCreate;
  PostponedAddScreenStatus(this._canCreate);

  _buildStatusMessages(canCreate) {
    if (canCreate['messages'].length > 0) {
      return Column(
        children: [
          for (var message in canCreate['messages'])
            Text(
              message,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    // if ()
    return _buildStatusMessages(_canCreate);
  }
}
