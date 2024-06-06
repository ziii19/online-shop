import 'package:flutter/material.dart';
import '../../../misc/constan.dart';

class ItemAccount extends StatelessWidget {
  const ItemAccount(
      {super.key,
      this.text = 'dhanisa',
      this.color = hitam,
      this.textSize = 18.0,
      required this.icon,
      this.iconSize = 25.0,
      this.onTap});

  final String text;
  final Color color;
  final double textSize;
  final IconData icon;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: color,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: textSize,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_outlined,
              size: iconSize,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
