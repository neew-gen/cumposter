import 'package:flutter/material.dart';
import 'package:vk_group_admin/widgets/postponed/post/post_attachments.dart';
import 'package:vk_group_admin/widgets/postponed/post/post_controls.dart';
import 'package:vk_group_admin/widgets/postponed/post/post_info.dart';
import 'package:vk_group_admin/widgets/postponed/post/post_text.dart';

class PostponedPost extends StatelessWidget {
  final postData;
  PostponedPost(this.postData);


  _buildPostControls() {
    return PostControls(postData['id']);
  }
  _buildPostAttachments() {
    if (postData['attachments'] != null) {
      return PostAttachments(attachments: postData['attachments']);
    }
  }
  _buildPostText() {
    if (postData['text'] != null) {
      return PostText(postData['text']);
    }
  }
  _buildPostInfo() {
    return PostInfo(postData);
  }
  _buildColumnChildren() {
    List<Widget> widgets = [];

    var postControls = _buildPostControls();
    widgets.add(postControls);

    var postAttachments = _buildPostAttachments();
    if (postAttachments != null) {
      widgets.add(postAttachments);
    }

    var postText = _buildPostText();
    if (postText != null) {
      widgets.add(postText);
    }

    var postInfo = _buildPostInfo();
    widgets.add(postInfo);

    return widgets;
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _buildColumnChildren(),
      ),
    );
  }
}

// class PostponedPost extends StatefulWidget {
//   final postData;
//   const PostponedPost(this.postData);
//   @override
//   PostponedPostState createState() => PostponedPostState();
// }
//
// class PostponedPostState extends State<PostponedPost> {
//   void clickDeletePost() {
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       var postponedPostsProvider =
//           Provider.of<PostponedPostsProvider>(context, listen: false);
//       postponedPostsProvider.deletePost(widget.groupId, widget.postData["id"]);
//     });
//   }
//
//   Widget _buildListTile() {
//     return ListTile(
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.delete_outline,
//               size: 20.0,
//             ),
//             onPressed: () {
//               clickDeletePost();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContainer() {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       alignment: Alignment.centerLeft,
//       child: Text(
//         widget.postData["id"].toString(),
//         style: TextStyle(color: Colors.black.withOpacity(0.6)),
//       ),
//     );
//   }
//
//   Widget? _buildPostAttachments() {
//     if (widget.postData["attachments"] != null) {
//       return PostAttachments(attachments: widget.postData["attachments"]);
//     }
//   }
//
//   List<Widget> _buildColumnChildren() {
//     List<Widget> widgets = [];
//
//     // Widget listTile = _buildListTile();
//     // widgets.create(listTile);
//     //
//     // Widget container = _buildContainer();
//     // widgets.create(container);
//     //
//     // Widget? postAttachments = _buildPostAttachments();
//     // widgets.create(postAttachments);
//     var listTile = _buildListTile();
//     widgets.create(listTile);
//     var container = _buildContainer();
//     widgets.create(container);
//     var postAttachments = _buildPostAttachments();
//     if (postAttachments != null) {
//       widgets.create(postAttachments);
//     }
//     return widgets;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         children: _buildColumnChildren(),
//       ),
//     );
//   }
// }
