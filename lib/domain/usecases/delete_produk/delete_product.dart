import 'package:online_shop/data/repositories/produk_repo.dart';
import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/delete_produk/delete_product_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

class DeleteProduct implements UseCase<Result<void>, DeleteProductParam> {
  final ProductRepo _productRepo;

  DeleteProduct({required ProductRepo productRepo})
      : _productRepo = productRepo;

  @override
  Future<Result<void>> call(DeleteProductParam params) async {
    var result = await _productRepo.deleteProduct(
        id: params.id, product: params.product);

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message)
    };
  }
}
