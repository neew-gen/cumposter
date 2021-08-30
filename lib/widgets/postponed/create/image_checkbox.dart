import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/postponed/create/create.dart';
import 'package:vk_group_admin/controllers/postponed/create/images.dart';

// class PostponedAddScreenImageCheckbox extends StatelessWidget {
//   final int _id;
//   final bool _checkboxValue;
//   PostponedAddScreenImageCheckbox(this._id, this._checkboxValue);
//
//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       value: _checkboxValue,
//       onChanged: (_) {
//         PostponedAddScreenImagesController.to
//             .updateImageCheckbox(_id, !_checkboxValue);
//         PostponedCreateController.to.fetchCanCreate();
//       },
//     );
//   }
// }

class PostponedAddScreenImageCheckbox extends StatefulWidget {
  final String _id;
  final bool _checkboxValue;
  PostponedAddScreenImageCheckbox(this._id, this._checkboxValue);
  @override
  _State createState() => _State();
}

class _State extends State<PostponedAddScreenImageCheckbox> {
  var _checkboxValue = false;
  @override
  void initState() {
    _checkboxValue = widget._checkboxValue;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _checkboxValue,
      onChanged: (_) {
        setState(() {
          _checkboxValue = !_checkboxValue;
        });
        PostponedCreateImagesController.to
            .updateImageCheckbox(widget._id, _checkboxValue);
        PostponedCreateController.to.fetchCanCreate();
      },
    );
  }
}
