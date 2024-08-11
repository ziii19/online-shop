import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/methods/int.dart';
import 'package:online_shop/presentation/provider/produk_data/produk_provider.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';
import '../../../domain/entities/product.dart';
import '../../misc/constan.dart';
import '../../misc/dimens.dart';

part 'sections/produk_item.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});

  @override
  ShopPageState createState() => ShopPageState();
}

class ShopPageState extends ConsumerState<ShopPage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(produkDataProvider);

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/mutushop_banner.png',
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.dp16),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search Store',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                  ),
                  Dimens.dp16.height,
                ],
              ),
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: produkItem(
              products: products,
              searchQuery: searchQuery,
              onTap: (product) {
                ref.read(routerProvider).pushNamed(
                      'detail-product',
                      extra: product,
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
