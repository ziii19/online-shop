import '../../../domain/usecases/get_all_product/get_all_product.dart';
import '../repositories/produk_repo/produk_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_product_prov.g.dart';

@riverpod
GetAllProduct getAllProduct(GetAllProductRef ref) =>
    GetAllProduct(productRepo: ref.watch(productRepoProvider));
