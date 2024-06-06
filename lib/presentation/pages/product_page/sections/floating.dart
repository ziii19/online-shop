part of '../product_page.dart';

Widget floatButton(WidgetRef ref) {
  return InkWell(
    onTap: () {
      ref.read(routerProvider).pushNamed('form-product');
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.dp16,
        vertical: Dimens.dp8,
      ),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(Dimens.dp8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: navy,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.add_rounded,
            color: scaffold,
          ),
          Dimens.dp8.width,
          const Text(
            'Add Product',
            style: TextStyle(color: white),
          )
        ],
      ),
    ),
  );
}
