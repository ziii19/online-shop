import '../../../data/repositories/produk_repo.dart';
import '../../entities/entities.dart';
import 'product_param.dart';
import '../usecase.dart';

class AddProduct implements UseCase<Result<void>, AddProductParam> {
  final ProductRepo _productRepo;

  AddProduct({required ProductRepo productRepo}) : _productRepo = productRepo;
  @override
  Future<Result<void>> call(AddProductParam params) async {
    var result = await _productRepo.addProduct(product: params.product);

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message)
    };
  }
}
