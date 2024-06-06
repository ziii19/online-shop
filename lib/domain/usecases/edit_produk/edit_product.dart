import '../../../data/repositories/produk_repo.dart';
import '../../entities/entities.dart';
import 'edit_product_param.dart';
import '../usecase.dart';

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
