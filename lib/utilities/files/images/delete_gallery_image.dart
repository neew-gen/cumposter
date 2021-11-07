import 'dart:io';

import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> deleteGalleryImage(File imageFile) async {
  try {
    await imageFile.delete();
  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}
