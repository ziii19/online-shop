import 'package:online_shop/presentation/methods/show_snackbar.dart';
import 'package:online_shop/presentation/pages/account_page/account_page.dart';
import 'package:online_shop/presentation/pages/cart_page/cart_page.dart';
import 'package:online_shop/presentation/pages/favorite_page/favorite_page.dart';
import 'package:online_shop/presentation/pages/shop_page/shop_page.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';
import 'package:online_shop/presentation/provider/user_data/user_data_prov.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int index = 0;

  final pages = <Widget>[
    const ShopPage(),
    const CartPage(),
    const FavoritePage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackbar(next.error.toString());
      }
    });
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
