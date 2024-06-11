import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/domain/entities/product.dart';
import 'package:online_shop/presentation/methods/int.dart';
import 'package:online_shop/presentation/methods/show_snackbar.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';
import 'package:online_shop/presentation/widgets/btn_widget.dart';

import '../../misc/constan.dart';
import '../../misc/favorite_button.dart';

class DetailProdukPage extends ConsumerWidget {
  final Product product;
  const DetailProdukPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          image: DecorationImage(
                            image: NetworkImage(
                              product.imgProduct,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              ref.read(routerProvider).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: hitam,
                              size: 25,
                            ),
                          ),
                          const Icon(
                            Icons.share,
                            color: hitam,
                            size: 25,
                          ),
                        ],
                      ),
                    )
                  ], 
                ),
              ),   
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
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
                                product.nameProduct,
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
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ProductQuantity(),
                          Text(
                            product.price.toIDRCurrencyFormat(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
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
                        product.desc,
                        style: const TextStyle(
                          fontSize: 14,
                          color: hitam,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: ButtonCustom(
          textBtn: 'Add To Cart',
          onPressed: () {
            context.showSnackbar('Fitur ini masih dalam pengembangan');
          },
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
