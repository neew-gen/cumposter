import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/enums/post_enums.dart';
import 'package:vk_group_admin/widgets/postponed/add_screen/posting_dialog.dart';
import 'package:vk_group_admin/widgets/postponed/add_screen/status.dart';

import 'error_dialog.dart';

class PostponedAddScreenCreateButton
    extends GetWidget<PostponedCreateController> {
  _createPost() {
    controller.savePost();
  }

  // _getStatusMessages(context, canCreate) {
  //   if (!canCreate['canCreateStatus']) {
  //     return Column(
  //       children: [
  //         for (var message in canCreate['messages'])
  //           Text(
  //             message,
  //             style: TextStyle(
  //               fontSize: 12.0,
  //             ),
  //           ),
  //       ],
  //     );
  //   } else {
  //     return Text('');
  //   }
  // }

  _getOnPressedMethod(canCreate) {
    var canCreateStatus = canCreate['canCreateStatus'];
    if (canCreateStatus) {
      return _createPost;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchCanCreate();
    // if ()
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PostponedAddScreenStatus(controller.canCreate),
          TextButton(
            onPressed: _getOnPressedMethod(controller.canCreate),
            child: Text('Создать'),
          ),
        ],
      ),
    );
  }
}

// class PostponedAddCreateButton extends StatefulWidget {
//   final int groupId;
//
//   const PostponedAddCreateButton(this.groupId);
//   // final bool canSave;
//   // const PostponedAddCreateButton({Key? key, required this.canSave})
//   //     : super(key: key);
//   @override
//   _PostponedAddCreateButtonState createState() =>
//       _PostponedAddCreateButtonState();
// }
//
// class _PostponedAddCreateButtonState extends State<PostponedAddCreateButton> {
//   var _canSave;
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   _createPost() {
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       var postponedAddSaveProvider =
//           Provider.of<PostponedAddSaveProvider>(context, listen: false);
//       postponedAddSaveProvider.savePost(widget.groupId);
//     });
//   }
//
//   _getOnPressedMethod() {
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       var postponedAddSaveProvider =
//           Provider.of<PostponedAddSaveProvider>(context, listen: false);
//       if (postponedAddSaveProvider.getCanSave()) {
//         setState(() {
//           _canSave = _createPost;
//         });
//       } else {
//         setState(() {
//           _canSave = null;
//         });
//       }
//     });
//     return _canSave;
//   }
//
//   String _getErrorText() {
//     if (_canSave == null) {
//       return 'На эту дату запланирована запись';
//     } else {
//       return '';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(_getErrorText()),
//         TextButton(
//           onPressed: _getOnPressedMethod(),
//           child: Text('Создать'),
//         ),
//       ],
//     );
//   }
// }
