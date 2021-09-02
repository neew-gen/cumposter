import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/posts.dart';
import 'package:vk_group_admin/utilities/date/unix_time.dart';

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
    var dateMap = formatTimeFromUnixToMapType(date);
    var now = DateTime.now();
    var nowYear = now.year;
    var nowMonth = now.month;
    var nowDay = now.day;

    var dateString;
    if (dateMap['year'] == nowYear && dateMap['month'] == nowMonth) {
      if (dateMap['day'] == nowDay) {
        dateString = 'Сегодня';
      } else if (dateMap['day'] - nowDay == 1) {
        dateString = 'Завтра';
      } else if (dateMap['day'] - nowDay == 2) {
        dateString = 'Послезавтра';
      } else {
        dateString = '${dateMap['day']}/${dateMap['month']}/${dateMap['year']}';
      }
    } else {
      dateString = '${dateMap['day']}/${dateMap['month']}/${dateMap['year']}';
    }

    var hour = dateMap['hour'];
    var minute = dateMap['minute'];
    var timeString = '$hour:$minute';

    return Text(
      '$dateString в $timeString',
    );
  }

  _buildAuthorText(postponedPostsController) {
    var authors = postponedPostsController.postponedPostsAuthors;
    var postAuthor =
        authors.where((author) => author['id'] == postData['signer_id']).toList();

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
