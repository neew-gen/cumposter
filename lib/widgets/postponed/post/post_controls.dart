import 'package:flutter/material.dart';
import 'package:cumposter/controllers/postponed/posts.dart';

class PostControls extends StatelessWidget {
  final postId;
  PostControls(this.postId);

  _deletePost() {
    PostponedPostsController.to.deletePost(postId);
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
