import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/posts.dart';
import 'package:cumposter/widgets/postponed/create/images.dart';
import 'package:cumposter/widgets/postponed/create/panel.dart';

import 'change_directory.dart';

class PostponedCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _goToChangeDirectory() {
      Get.to(() => ChangeDirectoryScreen());
    }

    _buildAppBar(postsLength) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Создать запись ($postsLength/100)',
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          IconButton(
              onPressed: _goToChangeDirectory,
              icon: Icon(
                Icons.folder,
              ))
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => _buildAppBar(PostponedPostsController.to.postponedPosts.length),
        ),
      ),
      body: PostponedCreateScreenImages(),
      bottomNavigationBar: StickyBottomAppBar(
        child: PostponedCreateScreenPanel(),
      ),
    );
  }
}

class StickyBottomAppBar extends StatelessWidget {
  final child;
  StickyBottomAppBar({required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -0.84 * MediaQuery.of(context).viewInsets.bottom),
      child: child,
    );
  }
}
