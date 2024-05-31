import 'package:online_shop/domain/usecases/get_produk/get_produk.dart';
import 'package:online_shop/presentation/provider/repositories/produk_repo/produk_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_product_prov.g.dart';

@riverpod
GetProduk getProduk(GetProdukRef ref) =>
    GetProduk(productRepo: ref.watch(productRepoProvider));
