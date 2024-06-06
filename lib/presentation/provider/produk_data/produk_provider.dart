import 'package:flutter/material.dart';
import 'package:online_shop/domain/usecases/edit_produk/edit_product.dart';
import 'package:online_shop/domain/usecases/edit_produk/edit_product_param.dart';
import 'package:online_shop/presentation/provider/usecase/usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/add_product/product.dart';
import '../../../domain/usecases/add_product/product_param.dart';
import '../../../domain/usecases/delete_produk/delete_product.dart';
import '../../../domain/usecases/delete_produk/delete_product_param.dart';
import '../../../domain/usecases/get_all_product/get_all_product.dart';
import '../usecase/add_produk_provider.dart';
import '../usecase/delete_produk_prov.dart';
import '../usecase/get_all_product_prov.dart';

part 'produk_provider.g.dart';

@Riverpod(keepAlive: true)
class ProdukData extends _$ProdukData {
  @override
  Future<List<Product>> build() async {
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

  Future<void> addProduct({
    required Product product,
  }) async {
    AddProduct addProduct = ref.read(addProductProvider);

    var result = addProduct(AddProductParam(product: product));

    switch (result) {
      case Success(value: final product):
        state = AsyncData(product);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull ?? []);
    }
  }

  Future<void> deleteProduct(
      {required String id, required Product product}) async {
    DeleteProduct deleteProduct = ref.read(deleteProductProvider);

    var result = deleteProduct(DeleteProductParam(id: id, product: product));

    switch (result) {
      case Success(value: final product):
        state = AsyncData(product);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull ?? []);
    }
  }

  Future<void> refreshProductData() async {
    state = const AsyncLoading();

    GetAllProduct getAllProduct = ref.read(getAllProductProvider);

    var result = await getAllProduct(null);

    switch (result) {
      case Success(value: final allProduct):
        state = AsyncData(allProduct);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull ?? []);
    }
  }

  Future<void> editProduct({required Product product}) async {
    state = const AsyncLoading();

    EditProduct editProduct = ref.read(editProductProvider);

    var result = editProduct(EditProductParam(product: product));

    switch (result) {
      case Success(value: final product):
        state = AsyncData(product);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull ?? []);
    }
  }
}
