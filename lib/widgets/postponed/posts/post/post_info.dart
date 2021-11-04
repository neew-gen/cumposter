import 'package:cumposter/utilities/next_post_time/get_date_range.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/posts.dart';
import 'package:cumposter/utilities/date/unix_time.dart';

class PostInfo extends StatelessWidget {
  final postData;
  PostInfo(this.postData);

  final PostponedPostsController _postponedPostsController =
      Get.put(PostponedPostsController());

  _buildRowChildren() {
    List<Widget> widgets = [];

    var dateText = _buildDateText();
    widgets.add(dateText);

    var authorText = Obx(() => _buildAuthorText(_postponedPostsController));
    widgets.add(authorText);

    return widgets;
  }

  _buildDateText() {
    var date = postData['date'];
    var postDate = getTimeFromUnixTime(date);

    final dateRange = getDateRange(postDate);

    final postDateToLocal = postDate.toLocal();
    var dateString =
        '${postDateToLocal.day}/${postDateToLocal.month}/${postDateToLocal.year}';
    var timeString = '${postDateToLocal.hour}:${postDateToLocal.minute}';

    return Text(
      '$dateRange, $dateString в $timeString',
    );
  }

  _buildAuthorText(postponedPostsController) {
    var authors = postponedPostsController.postponedPostsAuthors;
    var postAuthor = authors
        .where((author) => author['id'] == postData['signer_id'])
        .toList();

    if (postAuthor.isNotEmpty) {
      var name = postAuthor[0]['name'];
      return Text('Автор: $name');
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildRowChildren(),
      ),
    );
  }
}
