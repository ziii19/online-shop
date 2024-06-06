import '../../../domain/usecases/add_product/product.dart';
import '../repositories/produk_repo/produk_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_produk_provider.g.dart';

@riverpod
AddProduct addProduct(AddProductRef ref) =>
    AddProduct(productRepo: ref.watch(productRepoProvider));
