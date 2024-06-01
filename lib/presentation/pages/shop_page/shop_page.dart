import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/misc/dimens.dart';
import 'package:online_shop/presentation/widgets/text_field.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/mutushop_banner.png',
                height: 50,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Dimens.dp16),
              child: RegularTextInput(
                hintText: 'Search Store',
                prefixIcon: Icons.search,
              ),
            ),
            Dimens.dp16.height,
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
