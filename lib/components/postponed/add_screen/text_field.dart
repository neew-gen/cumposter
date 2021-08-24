import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';

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
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Текст записи',
            ),
            onChanged: (text) {
              _textChange(text);
            },
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
