import 'dart:io';

import '../../entities/entities.dart';

class UploadPPParam {
  final File imageFile;
  final User user;

  UploadPPParam({required this.imageFile, required this.user});
}
