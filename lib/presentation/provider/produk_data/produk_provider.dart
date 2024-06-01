// // import 'package:online_shop/domain/entities/entities.dart';
// // import 'package:riverpod_annotation/riverpod_annotation.dart';

// // part 'produk_provider.g.dart';

// // @Riverpod(keepAlive: true)
// // class ProdukData extends _$ProdukData {
// //   @override
// //   FutureOr<dynamic> build() => [];

// //   Future<List<Product>> getAllProduct() {
// //     state = AsyncLoading();
// //   }
// // }

// // import 'package:online_shop/domain/entities/entities.dart';
// // import 'package:online_shop/domain/usecases/get_all_product/get_all_product.dart';
// // import 'package:online_shop/presentation/provider/usecase/get_all_product_prov.dart';
// // import 'package:riverpod_annotation/riverpod_annotation.dart';

// // part 'produk_provider.g.dart';

// // @Riverpod(keepAlive: true)
// // class ProdukData extends _$ProdukData {
// //   @override
// //   Future<List<Product>> build() async {
// //     state = const AsyncLoading();

// //     GetAllProduct getAllProduct = ref.read(getAllProductProvider);
// //     var result = await getAllProduct(null);

// //     switch (result) {
// //       case Success(value: final listProduct):
// //         state = AsyncData(listProduct);
// //       case Failed(message: _):
// //         state = const AsyncData([]);
// //     }

// //     return const [];
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/get_all_product/get_all_product.dart';
import 'package:online_shop/domain/usecases/usecases.dart';
import 'package:online_shop/presentation/provider/usecase/get_all_product_prov.dart';
import 'package:online_shop/presentation/provider/usecase/usecase.dart';
import 'package:online_shop/presentation/provider/user_data/user_data_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'produk_provider.g.dart';

@Riverpod(keepAlive: true)
class ProdukData extends _$ProdukData {
  @override
  FutureOr<dynamic> build() => [];

  Future<List<Product>> getAllProduct() async {
    state = const AsyncLoading();

    GetAllProduct getAllProduct = ref.read(getAllProductProvider);
    var result = await getAllProduct(null);

    // Mengelola hasil dengan switch
    switch (result) {
      case Success(value: final listProduct):
        state = AsyncData(listProduct);
        return listProduct;
      case Failed(message: final errorMessage):
        state = AsyncError(FlutterError(errorMessage), StackTrace.current);
        return [];
      default:
        state = AsyncError(FlutterError('Unknown error'), StackTrace.current);
        return [];
    }
  }

  Future<List<Product?>> getProduct() async {
    state = const AsyncLoading();
    User? user = ref.read(userDataProvider).valueOrNull;

    GetProduk getProduk = ref.read(getProdukProvider);

    var result = getProduk(GetProductParam(uid: user!.uid));

    switch (result) {
      case Success(value: final listProduct):
        state = AsyncData(listProduct);
        return listProduct;
      case Failed(message: final errorMessage):
        state = AsyncError(errorMessage, StackTrace.current);
        return [];
      default:
        state = AsyncError('Unknown error', StackTrace.current);
        return [];
    }
  }

  Future<void> addProduct({
    required Product product,
  }) async {
    AddProduct addProduct = ref.read(addProductProvider);

    var result =
        addProduct(AddProductParam(product: product));

    switch (result) {
      case Success(value: final product):
        state = AsyncData(product);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  // Future<void> deleteProduct({required in id})
}
