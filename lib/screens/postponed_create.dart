import 'package:cumposter/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/posts.dart';
import 'package:cumposter/widgets/postponed/create/images.dart';
import 'package:cumposter/widgets/postponed/create/panel.dart';

class PostponedCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _buildAppBar(postsLength) {
      return AppbarTitle('Создать запись ($postsLength/100)');
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => _buildAppBar(PostponedPostsController.to.postponedPosts.length),
        ),
        automaticallyImplyLeading: false,
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
