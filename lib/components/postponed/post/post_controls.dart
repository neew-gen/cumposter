import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/postponed/posts.dart';

class PostControls extends StatelessWidget {
  final postId;
  PostControls(this.postId);
  final CurrentGroupController _currentGroupController =
  Get.put(CurrentGroupController());
  final PostponedPostsController _postponedPostsController =
  Get.put(PostponedPostsController());

  _deletePost() {
    var groupId = _currentGroupController.currentGroup['id'];
    _postponedPostsController.deletePost(groupId, postId);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 20.0,
            ),
            onPressed: () {
              _deletePost();
            },
          ),
        ],
      ),
    );
  }
}
