import 'package:online_shop/domain/usecases/delete_produk/delete_product.dart';
import 'package:online_shop/presentation/provider/repositories/produk_repo/produk_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_produk_prov.g.dart';

@riverpod
DeleteProduct deleteProduct(DeleteProductRef ref) =>
    DeleteProduct(productRepo: ref.watch(productRepoProvider));
