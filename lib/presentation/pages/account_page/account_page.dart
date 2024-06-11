import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/pages/account_page/sections/item_account.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';
import 'package:online_shop/presentation/provider/user_data/user_data_prov.dart';

import '../../misc/constan.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider).valueOrNull;

    return Scaffold(
      backgroundColor: scaffold,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 25),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: user?.photoProfile != null
                                ? NetworkImage(
                                    user!.photoProfile!,
                                  ) as ImageProvider
                                : const AssetImage('assets/images/ikon.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (user != null) ...[
                          Text(
                            user.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(color: abuAbu, fontSize: 16),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 1.0,
                color: abuAbu,
              ),
              const ItemAccount(
                icon: Icons.shopping_bag,
                text: 'Orders',
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 1.0,
                color: abuAbu,
              ),
              ItemAccount(
                icon: Icons.person,
                text: 'Edit Profile',
                onTap: () {
                  ref.read(routerProvider).pushNamed('edit-profile');
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 1.0,
                color: abuAbu,
              ),
              const ItemAccount(
                icon: Icons.location_on,
                text: 'Delivery Address',
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 1.0,
                color: abuAbu,
              ),
              ItemAccount(
                icon: Icons.help,
                text: 'Help',
                onTap: () {
                  ref.read(routerProvider).pushNamed('help');
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 1.0,
                color: abuAbu,
              ),
              const ItemAccount(
                icon: Icons.add_box_outlined,
                text: 'About',
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 1.0,
                color: abuAbu,
              ),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(320, 60),
            backgroundColor: scaffold,
          ),
          onPressed: () {
            ref.read(userDataProvider.notifier).logout();
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.logout_outlined),
              Expanded(
                flex: 3,
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
