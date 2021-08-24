import 'package:get/get.dart';
import 'package:vk_group_admin/utilities/vk/delete/delete_postponed_post.dart';
import 'package:vk_group_admin/utilities/vk/get/get_postponed_posts.dart';
import 'package:vk_group_admin/utilities/vk/get/get_users.dart';

class PostponedPostsController extends GetxController {
  var postponedPosts = [].obs;
  var postponedPostsAuthors = [].obs;

  Future fetchPostponedPosts(groupId) async {
    var fetchedPostponedPosts = await getPostponedPosts(groupId.toString());
    print(fetchedPostponedPosts.length);
    postponedPosts.value = fetchedPostponedPosts;
    _fetchPostponedPostsAuthors(fetchedPostponedPosts);
  }

  void deletePost(groupId, postId) async {
    var resultOfDelete =
        await deletePostponedPost(groupId.toString(), postId.toString());
    if (resultOfDelete != null) {
      fetchPostponedPosts(groupId);
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
