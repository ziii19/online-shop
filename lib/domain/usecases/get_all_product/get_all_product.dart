import 'package:online_shop/data/repositories/produk_repo.dart';
import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

class GetAllProduct implements UseCase<Result<List<Product>>, void> {
  final ProductRepo _productRepo;

  GetAllProduct({required ProductRepo productRepo})
      : _productRepo = productRepo;
  @override
  Future<Result<List<Product>>> call(void _) async {
    var result = await _productRepo.getAllProduct();

    return switch (result) {
      Success(value: final listResult) => Result.success(listResult),
      Failed(:final message) => Result.failed(message)
    };
  }
}
