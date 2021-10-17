// import 'package:flutter/material.dart';
// import 'package:vk_group_admin/controllers/groups/current.dart';
// import 'package:vk_group_admin/controllers/groups/managed.dart';
// import 'package:vk_group_admin/screens/managed_groups_menu.dart';
//
// class ManagedGroupsScreen extends StatelessWidget {
//   @override
//   Widget build(context) {
//     final ManagedGroupsController _managedGroupsController =
//         Get.put(ManagedGroupsController());
//     final CurrentGroupController _currentGroupController =
//         Get.put(CurrentGroupController());
//
//     _managedGroupsController.fetchManagedGroups();
//
//     _goToManagedGroupsMenuScreen(groupInfo) {
//       _currentGroupController.setCurrentGroup(groupInfo);
//       Get.to(ManagedGroupsMenuScreen());
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Группы под вашим управлением'),
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(children: [
//         for (var managedGroup in _managedGroupsController.managedGroups)
//           ListTile(
//             title: Text(managedGroup["name"]),
//             onTap: _goToManagedGroupsMenuScreen(managedGroup),
//           ),
//       ]),
//     );
//   }
// }
//
// // class ManagedGroupsScreen extends StatefulWidget {
// //   @override
// //   ManagedGroupsState createState() => ManagedGroupsState();
// // }
// //
// // class ManagedGroupsState extends State<ManagedGroupsScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
// //       var managedGroupsProvider =
// //           Provider.of<ManagedGroupsProvider>(context, listen: false);
// //       managedGroupsProvider.fetchManagedGroups();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Группы под вашим управлением'),
// //         automaticallyImplyLeading: false,
// //       ),
// //       body: Consumer<ManagedGroupsProvider>(
// //           builder: (context, managedGroupsProvider, child) {
// //         return Column(children: [
// //           for (var managedGroup in managedGroupsProvider.managedGroups)
// //             ListTile(
// //               title: Text(managedGroup["name"]),
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                       builder: (context) =>
// //                           ManagedGroupsMenuScreen(groupId: managedGroup["id"])),
// //                 );
// //               },
// //             ),
// //         ]);
// //       }),
// //     );
// //   }
// // }
