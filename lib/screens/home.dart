import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/groups/managed.dart';
import 'package:vk_group_admin/screens/managed_groups_menu.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/widgets/home/groups_list.dart';
import 'package:vk_group_admin/widgets/home/options.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(context) {
    final ManagedGroupsController _managedGroupsController =
        Get.put(ManagedGroupsController());
    final CurrentGroupController _currentGroupController =
        Get.put(CurrentGroupController());

    _managedGroupsController.fetchManagedGroups();

    _goToManagedGroupsMenuScreen(groupInfo) {
      _currentGroupController.setCurrentGroup(groupInfo);
      Get.to(() => ManagedGroupsMenuScreen());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          HomeGroupsList(),
          HomeOptions(),
        ],
      ),
    );
  }
}

// class Home extends StatefulWidget {
//   @override
//   HomeState createState() => HomeState();
// }
//
// class HomeState extends State<Home> {
//   @override
//   void initState() {
//     super.initState();
//     checkCredentials();
//   }
//
//   Future<void> checkCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     var token = prefs.getString("access_token");
//     var id = prefs.getString("user_id");
//     if (token != null && id != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ManagedGroupsScreen()),
//       );
//     }
//   }
//
//   void goToAuth() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => Auth()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                   "Для работы с приложением, пожалуйста, войдите в аккаунт ВК"),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: TextButton(
//         onPressed: goToAuth,
//         child: const Text('Войти'),
//       ),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   Home({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   HomeState createState() => HomeState();
// }
//
// class HomeState extends State<Home> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add_screen),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
