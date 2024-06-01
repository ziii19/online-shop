import '../../domain/entities/entities.dart';

abstract interface class ProductRepo {
  Future<Result<Product>> addProduct({required Product product});

  Future<Result<List<Product>>> getProduct({required String uid});
  Future<Result<List<Product>>> getAllProduct();

  Future<Result<Product>> editProduct({required Product product});
  Future<Result<void>> deleteProduct({required int id});
}
