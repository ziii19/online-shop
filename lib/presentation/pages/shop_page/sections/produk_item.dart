part of '../shop_page.dart';

Widget produkItem({
  required AsyncValue<List<Product>> products,
  String? searchQuery,
  void Function(Product product)? onTap,
}) {
  return GridView.count(
    padding: const EdgeInsets.only(bottom: 100),
    crossAxisCount: 2,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    childAspectRatio: 0.83,
    children: products.when(
      data: (data) {
        // Filter produk berdasarkan searchQuery
        final filteredProducts = data.where((product) {
          return product.nameProduct.toLowerCase().contains(searchQuery!);
        }).toList();

        return filteredProducts
            .map((e) => GestureDetector(
                  onTap: () => onTap?.call(e),
                  child: Container(
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
                                  image: NetworkImage(e.imgProduct),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.price.toIDRCurrencyFormat(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: navy,
                                borderRadius: BorderRadius.circular(14),
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
  );
}
