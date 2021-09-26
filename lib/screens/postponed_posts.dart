import 'package:cumposter/controllers/groups/settings.dart';
import 'package:cumposter/controllers/postponed/create/options.dart';
import 'package:flutter/material.dart';
import 'package:cumposter/widgets/postponed/post/post.dart';
import 'package:cumposter/controllers/postponed/posts.dart';
import 'package:cumposter/screens/postponed_create.dart';
import 'package:get/get.dart';

class PostponedPostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostponedPostsController.to
        .fetchPostponedPosts();
    // получаем настройки времени группы пока тут, чтобы когда пользователь
    // нажал создать запись, настройки уже были
    GroupSettingsController.to.fetchGroupTimeSettings();
    PostponedCreateOptionsController.to.fetchShowOptions();
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