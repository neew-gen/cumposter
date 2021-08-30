import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/create/create.dart';
import 'package:vk_group_admin/controllers/postponed/posts.dart';
import 'package:vk_group_admin/widgets/postponed/create/images.dart';
import 'package:vk_group_admin/widgets/postponed/create/panel.dart';

class PostponedCreateScreen extends GetWidget<PostponedCreateController> {
  @override
  Widget build(BuildContext context) {
    final PostponedPostsController _postponedPostsController = Get.find();

    _buildAppBar(postsLength) {
      return Text('Добавить запись ($postsLength/100)');
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => _buildAppBar(_postponedPostsController.postponedPosts.length),
        ),
      ),
      body: PostponedCreateScreenImages(),
      bottomNavigationBar: StickyBottomAppBar(
        child: PostponedCreateScreenPanel(),
      ),
    );
  }
}

class StickyBottomAppBar extends StatelessWidget {
  final child;
  StickyBottomAppBar({required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -0.84 * MediaQuery.of(context).viewInsets.bottom),
      child: child,
    );
  }
}
//
// class PostponedAddScreen extends StatefulWidget {
//   @override
//   PostponedAddState createState() => PostponedAddState();
// }
//
// class PostponedAddState extends State<PostponedAddScreen> {
//   List<AssetEntity> imageList = [];
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       var imagesFromGalleryProvider =
//           Provider.of<ImagesFromGalleryProvider>(context, listen: false);
//
//       imagesFromGalleryProvider.fetchImagesFromGallery();
//
//       var postponedAddOptionsProvider =
//           Provider.of<PostponedAddOptionsProvider>(context, listen: false);
//
//       postponedAddOptionsProvider.fetchImageCheckboxList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Добавить запись')),
//       body: Consumer<ImagesFromGalleryProvider>(
//           builder: (context, imagesFromGalleryProvider, child) {
//         return GridView.builder(
//           itemCount: imagesFromGalleryProvider.imageList.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount:
//                 MediaQuery.of(context).orientation == Orientation.landscape
//                     ? 3
//                     : 2,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//             childAspectRatio: (2 / 2),
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             return Consumer<PostponedAddOptionsProvider>(
//                 builder: (context, postponedAddOptionsProvider, child) {
//                   print(postponedAddOptionsProvider.imageCheckboxList);
//               return PostponedAddImage(
//                   imagesFromGalleryProvider.imageList[index],
//                   index,
//                   postponedAddOptionsProvider);
//             });
//           },
//         );
//       }),
//       // bottomNavigationBar: PostponedAddPanel(widget.groupId),
//     );
//   }
// }
