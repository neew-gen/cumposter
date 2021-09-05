import 'package:get/get.dart';
import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/utilities/vk/delete/delete_postponed_post.dart';
import 'package:cumposter/utilities/vk/get/get_postponed_posts.dart';
import 'package:cumposter/utilities/vk/get/get_users.dart';

class PostponedPostsController extends GetxController {
  static PostponedPostsController get to => Get.find();

  var postponedPosts = [].obs;
  var postponedPostsAuthors = [].obs;

  Future fetchPostponedPosts() async {
    String groupId = CurrentGroupController.to.currentGroup.value.id;
    var fetchedPostponedPosts = await getPostponedPosts(groupId.toString());
    postponedPosts.value = fetchedPostponedPosts;
    _fetchPostponedPostsAuthors(fetchedPostponedPosts);
  }

  void deletePost(postId) async {
    var groupId = CurrentGroupController.to.currentGroup.value.id;
    var resultOfDelete =
        await deletePostponedPost(groupId.toString(), postId.toString());
    if (resultOfDelete != null) {
      fetchPostponedPosts();
    }
  }

  _fetchPostponedPostsAuthors(postponedPosts) async {
    var authorsIds = [];
    for (var post in postponedPosts) {
      if (post['signer_id'] != null) {
        authorsIds.add(post['signer_id']);
      }
    }
    if (authorsIds.isNotEmpty) {
      List fetchedUsers = await getUsers(authorsIds);
      if (fetchedUsers.isNotEmpty) {
        var postponedAuthorsList = [];
        for (var user in fetchedUsers) {
          var firstName = user['first_name'];
          var lastName = user['last_name'];
          postponedAuthorsList
              .add({'id': user['id'], 'name': '$firstName $lastName'});
        }
        postponedPostsAuthors.value = postponedAuthorsList;
      }
    }
  }
}
