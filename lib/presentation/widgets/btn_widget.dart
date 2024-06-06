import 'package:flutter/material.dart';
import '../misc/constan.dart';

class ButtonCustom extends StatelessWidget {
  final String textBtn;
  final Color? color;
  final Color? bgColor;
  final VoidCallback? onPressed;
  const ButtonCustom({
    super.key,
    required this.textBtn,
    this.color = white,
    this.bgColor = orange,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: bgColor),
          onPressed: onPressed,
          child: Text(
            textBtn,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          )),
    );
  }
}
