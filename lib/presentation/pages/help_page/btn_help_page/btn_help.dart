import 'package:flutter/material.dart';
import 'package:online_shop/presentation/misc/constan.dart';

class BtnHelp extends StatelessWidget {
  const BtnHelp({
    super.key,
    required this.icon,
    this.iconSize = 25.0,
    this.color = hitam,
    this.text = 'helpme',
    this.textSize = 18.0,
  });

  final IconData icon;
  final double iconSize;
  final Color color;
  final String text;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[80],
              minimumSize: const Size(364, 67),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: color,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: color,
                      fontSize: textSize,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
