import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/domain/entities/product.dart';
import 'package:online_shop/presentation/provider/user_data/user_data_prov.dart';

import '../../misc/constan.dart';
import '../../misc/dimens.dart';
import '../../provider/produk_data/produk_provider.dart';
import '../../provider/router/router_provider.dart';
import '../../widgets/text_field.dart';

part 'sections/floating.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(Dimens.dp16),
            child: RegularTextInput(
              hintText: 'Search Product',
              prefixIcon: Icons.search,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.83,
                  children: ref.watch(produkDataProvider).when(
                      data: (data) => data
                          .where((element) =>
                              element.uid ==
                              ref.watch(userDataProvider).valueOrNull!.uid)
                          .toList()
                          .map((product) => ItemProduct(product: product))
                          .toList(),
                      error: (error, stackTrace) => [],
                      loading: () => [
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ]),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatButton(ref),
    );
  }
}

class ItemProduct extends ConsumerWidget {
  final Product product;
  const ItemProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                    image: NetworkImage(product.imgProduct),
                    fit: BoxFit.cover)),
          ),
          Dimens.dp8.height,
          Text(
            product.nameProduct,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimens.dp20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(routerProvider)
                          .pushNamed('edit-product', extra: product);
                    },
                    child: const Center(
                      child: Text('Edit'),
                    ),
                  ),
                ),
              ),
              Dimens.dp8.width,
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(produkDataProvider.notifier)
                          .deleteProduct(id: product.id, product: product);
                      ref
                          .read(produkDataProvider.notifier)
                          .refreshProductData();
                    },
                    child: const Center(
                      child: Text('Delete'),
                    ),
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
