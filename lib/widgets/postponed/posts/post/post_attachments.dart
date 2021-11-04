import 'package:cumposter/widgets/shared/full_screen_image_wrapper/full_screen_image_wrapper.dart';
import 'package:flutter/material.dart';

class PostAttachments extends StatefulWidget {
  final attachments;

  const PostAttachments({Key? key, this.attachments}) : super(key: key);
  @override
  PostAttachmentsState createState() => PostAttachmentsState();
}

class PostAttachmentsState extends State<PostAttachments> {
  @override
  Widget build(BuildContext context) {
    var photos =
        widget.attachments.where((elem) => elem["type"] == "photo").toList();
    var crossAxisCount = getCrossAxisCount(photos);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: photos.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemBuilder: (BuildContext context, int index) {
          var imageUrl = getImageUrl(photos, photos[index]["photo"]["sizes"]);
          return FullScreenImageWrapper(
            child: Image.network(imageUrl),
            dark: true,
          );
        },
      ),
    );
  }
}

getCrossAxisCount(photos) {
  var photosLength = photos.length;
  switch (photosLength) {
    case 1:
      return 1;
    case 2:
      return 2;
    default:
      return 3;
  }
}

getImageUrl(photos, photoSizes) {
  var photosLength = photos.length;
  photoSizes.sort((a, b) => b['height'].compareTo(a['height']) as int);
  switch (photosLength) {
    case 1:
      return photoSizes[0]["url"];
    case 2:
      return photoSizes[3]["url"];
    default:
      return photoSizes[4]["url"];
  }
}
