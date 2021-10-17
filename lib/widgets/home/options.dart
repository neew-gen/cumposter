// import 'package:flutter/material.dart';
// import 'package:cumposter/controllers/groups/current.dart';
// import 'package:cumposter/controllers/groups/managed.dart';
// import 'package:cumposter/screens/managed_groups_menu.dart';
// import 'package:cumposter/screens/options.dart';
//
// import 'group.dart';
//
// class HomeOptions extends StatelessWidget {
//   @override
//   Widget build(context) {
//     final ManagedGroupsController _managedGroupsController =
//         Get.put(ManagedGroupsController());
//     // final CurrentGroupController _currentGroupController =
//     //     Get.put(CurrentGroupController());
//
//     _managedGroupsController.fetchManagedGroups();
//
//     // _goToManagedGroupsMenuScreen(groupInfo) {
//     //   _currentGroupController.setCurrentGroup(groupInfo);
//     //   Get.to(() => ManagedGroupsMenuScreen());
//     // }
//     _goToOptionsPage() {
//       Get.to(
//         () => OptionsScreen(),
//       );
//     }
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextButton(
//           onPressed: _goToOptionsPage,
//           child: Text('Настройки приложения'),
//         )
//       ],
//     );
//   }
// }
