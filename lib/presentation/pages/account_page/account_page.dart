import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/provider/user_data/user_data_prov.dart';
import 'package:online_shop/presentation/widgets/btn_widget.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: ButtonCustom(
        textBtn: 'Logout',
        onPressed: () {
          ref.read(userDataProvider.notifier).logout();
        },
      )),
    );
  }
}
