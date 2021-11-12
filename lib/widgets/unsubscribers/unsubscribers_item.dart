import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class UnsubscribersItem extends StatelessWidget {
  final _unsubscriber;

  UnsubscribersItem(this._unsubscriber);
  _buildDate() {
    var dateString = DateTime.fromMillisecondsSinceEpoch(_unsubscriber['date']);
    final DateFormat formatter = DateFormat('dd-MM-yyyy в HH:mm');
    return Text(formatter.format(dateString));
  }

  _onLinkTap() async {
    var userLink = 'https://vk.com/${_unsubscriber['domain']}';
    await canLaunch(userLink)
        ? await launch(userLink)
        : throw 'Could not launch $userLink';
  }

  _buildUserInfo() {
    var userName = _unsubscriber['name'];
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
          text: ' ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: userName,
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = _onLinkTap,
        ),
      ],
    ));
  }

  _buildUserAction() {
    var leftBySelf = _unsubscriber['self'];
    if (leftBySelf) {
      return Text(' покинул(а) группу.');
    } else {
      return Text(' удален(а) из группы.');
    }
  }

  _buildRow() {
    List<Widget> row = [];

    var date = _buildDate();
    row.add(date);

    var userInfo = _buildUserInfo();
    row.add(userInfo);
    var userAction = _buildUserAction();
    row.add(userAction);

    return row;
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        children: _buildRow(),
      ),
    );
  }
}
