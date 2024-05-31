import 'package:online_shop/data/repositories/produk_repo.dart';
import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/add_product/product_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

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
