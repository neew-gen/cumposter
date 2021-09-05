import 'dart:io';

Future<void> deleteGalleryImage(File imageFile) async {
  await imageFile.delete();
}
