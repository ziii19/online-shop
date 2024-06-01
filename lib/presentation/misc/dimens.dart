import 'package:flutter/material.dart';

class Dimens {
  Dimens._();

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static const dp2 = 2.0;
  static const dp4 = 4.0;
  static const dp6 = 6.0;
  static const dp8 = 8.0;
  static const dp10 = 10.0;
  static const dp12 = 12.0;
  static const dp14 = 14.0;
  static const dp16 = 16.0;
  static const dp18 = 18.0;
  static const dp20 = 20.0;
  static const dp22 = 22.0;
  static const dp24 = 24.0;
  static const dp26 = 26.0;
  static const dp32 = 32.0;
  static const dp38 = 38.0;
  static const dp40 = 40.0;
  static const dp48 = 48.0;
  static const dp50 = 50.0;
  static const dp80 = 80.0;
  static const dp100 = 100.0;
  static const dp200 = 200.0;
}

extension SizedBoxExtension on double {
  SizedBox get width => SizedBox(width: this);
  SizedBox get height => SizedBox(height: this);
}