import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/methods/int.dart';
import 'package:online_shop/presentation/provider/produk_data/produk_provider.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';

import '../../../domain/entities/user.dart';
import '../../misc/constan.dart';
import '../../misc/dimens.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: navy,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(.3),
                            child: IconButton(
                                onPressed: () {
                                  ref.read(routerProvider).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: scaffold,
                                )),
                          ),
                        ),
                        Dimens.dp8.height,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: user.photoProfile != null
                                          ? NetworkImage(
                                              user.photoProfile!,
                                            ) as ImageProvider
                                          : const AssetImage(
                                              'assets/images/ikon.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Dimens.dp16.width,
                              Text(
                                user.name,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Dimens.dp20.height,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Product',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Dimens.dp16.height,
              ],
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            padding: const EdgeInsets.only(bottom: 100),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.83,
            children: ref.watch(produkDataProvider).when(
                  data: (data) {
                    // Filter produk berdasarkan searchQuery
                    final product = data.where((product) {
                      return product.uid == user.uid;
                    }).toList();

                    return product
                        .map((e) => GestureDetector(
                              onTap: () {
                                ref
                                    .read(routerProvider)
                                    .pushNamed('detail-product', extra: e);
                              },
                              child: Container(
                                width: 170,
                                padding: const EdgeInsets.all(Dimens.dp10),
                                decoration: BoxDecoration(
                                    color: scaffold,
                                    borderRadius:
                                        BorderRadius.circular(Dimens.dp14),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 110,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(
                                            color:
                                                Colors.purple.withOpacity(.5),
                                          )),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageUrl: e.imgProduct,
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Dimens.dp8.height,
                                    Text(
                                      e.nameProduct,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Dimens.dp20.height,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.price.toIDRCurrencyFormat(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: navy,
                                            borderRadius:
                                                BorderRadius.circular(14),
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
                              ),
                            ))
                        .toList();
                  },
                  error: (error, stackTrace) => [],
                  loading: () => [const CircularProgressIndicator()],
                ),
          ),
        ),
      ),
    );
  }
}
