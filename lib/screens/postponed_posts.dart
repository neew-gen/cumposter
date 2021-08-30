import 'package:flutter/material.dart';
import 'package:vk_group_admin/widgets/postponed/post/post.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/postponed/posts.dart';
import 'package:vk_group_admin/screens/postponed_create.dart';
import 'package:get/get.dart';

class PostponedPostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostponedPostsController.to
        .fetchPostponedPosts(CurrentGroupController.to.currentGroup['id']);

    _goToPostponedAddScreen() {
      Get.to(() => PostponedCreateScreen());
    }

    _buildAppBar(postsLength) {
      return Text('Отложенные записи ($postsLength/100)');
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => _buildAppBar(PostponedPostsController.to.postponedPosts.length),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: PostponedPostsController.to.postponedPosts.length,
          itemBuilder: (BuildContext context, int index) {
            return PostponedPost(
                PostponedPostsController.to.postponedPosts[index]);
          },
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          _goToPostponedAddScreen();
        },
        child: const Text('Создать'),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}