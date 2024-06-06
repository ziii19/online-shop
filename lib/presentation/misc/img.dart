import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper._();

  static Future<String?> getImage() async {
    try {
      final picker = ImagePicker();

      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return base64Encode(await image.readAsBytes());
      }
      return null;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  static Uint8List convertToUint8List(String bytes) {
    return base64Decode(bytes);
  }
}
