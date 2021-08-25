import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';

import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';
import 'package:get/get.dart';

// class PostponedAddScreenTextField extends StatefulWidget {
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<PostponedAddScreenTextField> {
//   late TextEditingController _controller;
//   final PostponedAddOptionsController _postponedAddTimeController =
//       Get.put(PostponedAddOptionsController());
//   final PostponedCreateController _postponedCreateController =
//       Get.put(PostponedCreateController());
//   final PostponedAddOptionsController _postponedAddOptionsController =
//   Get.put(PostponedAddOptionsController());
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.clear();
//     super.dispose();
//   }
//
//   _textChange(text) {
//     _postponedAddTimeController.updateText(text);
//     _postponedCreateController.fetchCanCreate();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Obx(
//             () => TextFormField(
//               initialValue: _postponedAddOptionsController.text.value,
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 labelText: 'Текст записи',
//               ),
//               onChanged: (text) {
//                 _textChange(text);
//               },
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

class PostponedAddScreenTextField extends StatelessWidget {
  final PostponedAddOptionsController _postponedAddTimeController =
      Get.put(PostponedAddOptionsController());
  final PostponedCreateController _postponedCreateController =
      Get.put(PostponedCreateController());

  _textChange(text) {
    _postponedAddTimeController.updateText(text);
    _postponedCreateController.fetchCanCreate();
  }

  @override
  Widget build(BuildContext context) {
    final PostponedAddOptionsController _postponedAddOptionsController =
        Get.put(PostponedAddOptionsController());
    var text = _postponedAddOptionsController.text;

    return Row(
      children: [
        Expanded(
          child: Obx(
            () => TextFormField(
              controller: TextEditingController()..text = '$text',
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Текст записи',
              ),
              onChanged: (text) {
                _textChange(text);
              },
            ),
          ),
        )
      ],
    );
  }
}

// class PostponedAddTextField extends StatefulWidget {
//   @override
//   _PostponedAddTextFieldState createState() => _PostponedAddTextFieldState();
// }
//
// class _PostponedAddTextFieldState extends State<PostponedAddTextField> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   _textChange(text) {
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       PostponedAddOptionsProvider provider =
//           Provider.of<PostponedAddOptionsProvider>(context, listen: false);
//
//       provider.updateText(text);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             decoration: InputDecoration(
//               border: UnderlineInputBorder(),
//               labelText: 'Текст записи',
//             ),
//             onChanged: (text) {
//               _textChange(text);
//             },
//           ),
//         )
//       ],
//     );
//   }
// }
