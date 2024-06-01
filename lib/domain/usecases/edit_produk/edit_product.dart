import 'package:online_shop/data/repositories/produk_repo.dart';
import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/edit_produk/edit_product_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

class EditProduct implements UseCase<Result<void>, EditProductParam> {
  final ProductRepo _productRepo;

  EditProduct({required ProductRepo productRepo}) : _productRepo = productRepo;
  @override
  Future<Result<void>> call(EditProductParam params) async {
    var result = await _productRepo.editProduct(product: params.product);

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message)
    };
  }
}
