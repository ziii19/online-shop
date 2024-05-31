import 'package:online_shop/domain/usecases/usecases.dart';
import 'package:online_shop/presentation/provider/repositories/produk_repo/produk_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_product_prov.g.dart';

@riverpod
EditProduct editProduct(EditProductRef ref) =>
    EditProduct(productRepo: ref.watch(productRepoProvider));
