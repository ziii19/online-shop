import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/domain/entities/product.dart';
import 'package:online_shop/presentation/methods/int.dart';
import 'package:online_shop/presentation/misc/dimens.dart';
import 'package:online_shop/presentation/provider/produk_data/produk_provider.dart';
import 'package:online_shop/presentation/provider/produk_data/user_product_prov.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';
import 'package:online_shop/presentation/widgets/btn_widget.dart';

import '../../../domain/entities/entities.dart';
import '../../misc/constan.dart';
import '../../misc/favorite_button.dart';

part 'section/user_product.dart';

class DetailProdukPage extends ConsumerStatefulWidget {
  final Product product;
  const DetailProdukPage({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailProdukPageState();
}

class _DetailProdukPageState extends ConsumerState<DetailProdukPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) setState(() => _isVisible = false);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider(uid: widget.product.uid));
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.product.imgProduct,
                              ),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                ref.read(routerProvider).pop();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(.4),
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: white,
                                  size: 25,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(.4),
                              child: const Icon(
                                Icons.share,
                                color: white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.nameProduct,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: hitam),
                            ),
                            const Text(
                              '1Kg, Price',
                              style: TextStyle(fontSize: 16, color: hitam),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, right: 20),
                        child: FavoriteButton(),
                      ),
                    ],
                  ),
                  Dimens.dp16.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ProductQuantity(),
                        Text(
                          widget.product.price.toIDRCurrencyFormat(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Dimens.dp24.height,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Detail',
                          style: TextStyle(
                            fontSize: 20,
                            color: hitam,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.product.desc,
                      style: const TextStyle(
                        fontSize: 14,
                        color: hitam,
                      ),
                    ),
                  ),
                  Dimens.dp50.height,
                  user.when(
                    data: (data) => _UserProductSection(
                      ref: ref,
                      user: data!,
                      id: widget.product.id,
                    ),
                    error: (error, stackTrace) => Text('error $error'),
                    loading: () => const CircularProgressIndicator(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isVisible ? kBottomNavigationBarHeight : 0.0,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: ButtonCustom(
                textBtn: 'Add To Cart',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Fitur ini masih dalam pengembangan')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductQuantity extends StatefulWidget {
  const ProductQuantity({
    super.key,
  });

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  int quantity = 0; // Membuat quantity sebagai variabel state

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove_circle_outline,
            size: 28,
            color: Colors.grey,
          ),
          onPressed: _decrementQuantity,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '$quantity',
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(
          width: 8,
        ),
        IconButton(
          icon: const Icon(
            Icons.add_circle_outline,
            size: 28,
          ),
          onPressed: _incrementQuantity,
        ),
      ],
    );
  }
}
