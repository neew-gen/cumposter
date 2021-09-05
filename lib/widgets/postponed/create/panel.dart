import 'package:flutter/material.dart';
import 'package:cumposter/widgets/postponed/create/text_field.dart';

import 'create_button.dart';
import 'date_picker.dart';

class PostponedCreateScreenPanel extends StatelessWidget {
  // _buildDeleteCheckbox() {
  //   return PostponedAddDeleteCheckbox();
  // }

  _buildTextField() {
    return PostponedCreatePanelTextField();
  }

  _buildDatePicker() {
    return PostponedCreatePanelDatePicker();
  }

  _buildCreateButton() {
    return PostponedCreatePanelCreateButton();
  }




  _buildColumnChildren() {
    List<Widget> widgets = [];

    // var deleteCheckbox = _buildDeleteCheckbox();
    // widgets.create(deleteCheckbox);

    var textField = _buildTextField();
    widgets.add(textField);

    var datePicker = _buildDatePicker();
    widgets.add(datePicker);

    var createButton = _buildCreateButton();
    widgets.add(createButton);

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
        _buildColumnChildren(),
      ),
    );
  }
}

// class PostponedAddScreenPanel extends StatefulWidget {
//   final int groupId;
//
//   const PostponedAddScreenPanel(this.groupId);
//   @override
//   _PostponedAddPanelState createState() => _PostponedAddPanelState();
// }
//
// class _PostponedAddPanelState extends State<PostponedAddPanel> {
//   bool _deleteImageAfterSaving = false;
//   @override
//   void initState() {
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text("Удалить картинку после сохранения"),
//               Checkbox(
//                 value: _deleteImageAfterSaving,
//                 onChanged: (_) {
//                   setState(() {
//                     _deleteImageAfterSaving = !_deleteImageAfterSaving;
//                   });
//                   _changeDeleteImageAfterSaving();
//                 },
//               ),
//             ],
//           ),
//           PostponedAddTextField(),
//           Consumer<PostponedAddTimeProvider>(
//               builder: (context, postponedTimeProvider, child) {
//             return PostponedAddDatePicker(
//               nextPostTime: postponedTimeProvider.nextPostTime,
//               dateRangeString: postponedTimeProvider.dateRangeString,
//             );
//           }),
//           Consumer<PostponedAddSaveProvider>(
//               builder: (context, postponedAddSaveProvider, child) {
//             return PostponedAddCreateButton(widget.groupId);
//           }),
//         ],
//       ),
//     );
//   }
// }
