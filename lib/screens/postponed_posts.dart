import 'package:flutter/material.dart';
import 'package:vk_group_admin/components/postponed/post/post.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/postponed/posts.dart';
import 'package:vk_group_admin/screens/postponed_add.dart';
import 'package:get/get.dart';

class PostponedPostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CurrentGroupController _currentGroupController =
        Get.put(CurrentGroupController());
    final PostponedPostsController _postponedPostsController =
        Get.put(PostponedPostsController());

    _postponedPostsController
        .fetchPostponedPosts(_currentGroupController.currentGroup['id']);

    _goToPostponedAddScreen() {
      Get.to(PostponedAddScreen());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Отложенные записи')),
      body: Obx(
        () => ListView.builder(
          itemCount: _postponedPostsController.postponedPosts.length,
          itemBuilder: (BuildContext context, int index) {
            return PostponedPost(
                _postponedPostsController.postponedPosts[index]);
          },
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          _goToPostponedAddScreen();
        },
        child: const Text('Добавить'),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

// class PostponedPostsScreen extends StatefulWidget {
//   final int groupId;
//
//   const PostponedPostsScreen({Key? key, required this.groupId})
//       : super(key: key);
//   @override
//   PostponedPostsState createState() => PostponedPostsState();
// }
//
// class PostponedPostsState extends State<PostponedPostsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       var postponedPostsProvider =
//           Provider.of<PostponedPostsProvider>(context, listen: false);
//       postponedPostsProvider.fetchPostponedPosts(widget.groupId);
//     });
//   }
//
//   void goToAdd() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => PostponedAddScreen(widget.groupId)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Отложенные записи')),
//       body: Consumer<PostponedPostsProvider>(
//           builder: (context, postponedPostsProvider, child) {
//         // for (var postponedPost in postponedPostsProvider.postponedPosts)
//         return ListView.builder(
//           itemCount: postponedPostsProvider.postponedPosts.length,
//           itemBuilder: (BuildContext context, int index) {
//             return PostponedPost(
//                 groupId: widget.groupId,
//                 postData: postponedPostsProvider.postponedPosts[index]);
//           },
//         );
//       }),
//       floatingActionButton: TextButton(
//         onPressed: goToAdd,
//         child: const Text('Добавить'),
//         style: TextButton.styleFrom(
//           backgroundColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }
