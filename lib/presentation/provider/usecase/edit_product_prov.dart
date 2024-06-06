import '../../../domain/usecases/edit_produk/edit_product.dart';
import '../repositories/produk_repo/produk_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_product_prov.g.dart';

@riverpod
EditProduct editProduct(EditProductRef ref) =>
    EditProduct(productRepo: ref.watch(productRepoProvider));
