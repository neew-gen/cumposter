import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/create/create.dart';
import 'package:cumposter/controllers/postponed/create/options.dart';

// class PostponedCreatePanelTextField extends StatefulWidget {
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<PostponedCreatePanelTextField> {
//   final _controller = TextEditingController();
//
//   final _focusNode = FocusNode();
//
//   @override
//   void initState() {
//     // _focusNode.addListener(() {
//     //   print(_focusNode.hasFocus);
//     // });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     var text = '';
//     _textChange(text) {
//       PostponedCreateOptionsController.to.updateText(text);
//       PostponedCreateController.to.fetchCanCreate();
//     }
//
//     return Row(
//       children: [
//         Expanded(
//           child: Obx(
//             () => TextFormField(
//               controller: _controller
//                 ..value = TextEditingValue(
//                   text: text,
//                   // selection: TextSelection.collapsed(offset: text.length),
//                 ),
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 labelText: 'Текст записи',
//               ),
//               onChanged: (text) {
//                 _textChange(text);
//                 // _controller.value = TextEditingValue(
//                 //   text: text,
//                 //   selection: TextSelection.collapsed(offset: text.length),
//                 // );
//               },
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

class PostponedCreatePanelTextField
    extends GetView<PostponedCreateOptionsController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Form(
            key: controller.optionsFormKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Текст записи',
                  ),
                  maxLines: 10,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.text.value = value;
                    PostponedCreateController.to.fetchCanCreate();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
