import 'package:flutter/material.dart';

import '../misc/constan.dart';
import '../misc/dimens.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(Dimens.dp10),
      decoration: BoxDecoration(
          color: scaffold,
          borderRadius: BorderRadius.circular(Dimens.dp14),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/product.png'))),
          ),
          const Text(
            'Meja Kayu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimens.dp20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rp 200.000,-',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: scaffold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
