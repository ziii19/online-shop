part of '../detail_produk_page.dart';

class _UserProductSection extends StatelessWidget {
  const _UserProductSection({
    required this.ref,
    required this.user,
    required this.id,
  });

  final WidgetRef ref;
  final User user;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          : const AssetImage('assets/images/ikon.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Dimens.dp16.width,
              Text(
                user.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Dimens.dp10.height,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('More product', style: TextStyle(fontSize: 16)),
              Dimens.dp16.height,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ref.watch(produkDataProvider).when(
                        data: (product) => product
                            .where((element) =>
                                element.uid == user.uid && element.id != id)
                            .toList()
                            .map((e) => Padding(
                                  padding: EdgeInsets.only(
                                    right: e != product.last ? 16 : 0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(routerProvider)
                                          .goNamed('detail-product', extra: e);
                                    },
                                    child: Container(
                                      width: 170,
                                      padding:
                                          const EdgeInsets.all(Dimens.dp10),
                                      decoration: BoxDecoration(
                                          color: scaffold,
                                          borderRadius: BorderRadius.circular(
                                              Dimens.dp14),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 110,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        e.imgProduct),
                                                    fit: BoxFit.cover)),
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                  ),
                                ))
                            .toList(),
                        error: (error, stackTrace) => [],
                        loading: () => [const CircularProgressIndicator()],
                      ),
                ),
              )
            ],
          ),
        ),
        Dimens.dp20.height,
      ],
    );
  }
}
