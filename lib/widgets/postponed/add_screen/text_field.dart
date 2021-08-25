import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';

import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/postponed/add/create.dart';
import 'package:vk_group_admin/controllers/postponed/add/options.dart';
import 'package:get/get.dart';

class PostponedAddScreenTextField extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<PostponedAddScreenTextField> {
  final PostponedAddOptionsController _postponedAddTimeController =
      Get.put(PostponedAddOptionsController());
  final PostponedCreateController _postponedCreateController =
      Get.put(PostponedCreateController());
  final PostponedAddOptionsController _postponedAddOptionsController =
      Get.put(PostponedAddOptionsController());
  final _controller = TextEditingController();

  final _focusNode = FocusNode();

  @override
  void initState() {
    // _focusNode.addListener(() {
    //   print(_focusNode.hasFocus);
    // });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PostponedAddOptionsController _postponedAddOptionsController =
        Get.put(PostponedAddOptionsController());

    var text = _postponedAddOptionsController.text;
    _textChange(text) {
      _postponedAddTimeController.updateText(text);
      _postponedCreateController.fetchCanCreate();
    }

    return Row(
      children: [
        Expanded(
          child: Obx(
            () => TextFormField(
              controller: _controller
                ..value = TextEditingValue(
                  text: '$text',
                  selection: TextSelection.collapsed(offset: '$text'.length),
                ),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Текст записи',
              ),
              onChanged: (text) {
                _textChange(text);
                // _controller.value = TextEditingValue(
                //   text: text,
                //   selection: TextSelection.collapsed(offset: text.length),
                // );
              },
            ),
          ),
        )
      ],
    );
  }
}

// class PostponedAddScreenTextField extends StatelessWidget {
//   final PostponedAddOptionsController _postponedAddTimeController =
//       Get.put(PostponedAddOptionsController());
//   final PostponedCreateController _postponedCreateController =
//       Get.put(PostponedCreateController());
//
//   _textChange(text) {
//     _postponedAddTimeController.updateText(text);
//     _postponedCreateController.fetchCanCreate();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final PostponedAddOptionsController _postponedAddOptionsController =
//         Get.put(PostponedAddOptionsController());
//     var text = _postponedAddOptionsController.text;
//
//     return Row(
//       children: [
//         Expanded(
//           child: Obx(
//             () => TextFormField(
//               controller: TextEditingController()..text = '$text',
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 labelText: 'Текст записи',
//               ),
//               onFieldSubmitted: (text) {
//                 _textChange(text);
//               },
//               onTap: () {
//                 print('tap');
//               },
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

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
