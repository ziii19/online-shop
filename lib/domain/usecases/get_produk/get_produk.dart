import 'package:online_shop/data/repositories/produk_repo.dart';
import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/get_produk/get_produk_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

class GetProduk implements UseCase<Result<List<Product>>, GetProductParam> {
  final ProductRepo _productRepo;

  GetProduk({required ProductRepo productRepo}) : _productRepo = productRepo;
  @override
  Future<Result<List<Product>>> call(GetProductParam params) async {
    var listProduk = await _productRepo.getProduct(uid: params.uid);

    return switch (listProduk) {
      Success(value: final listResult) => Result.success(listResult),
      Failed(:final message) => Result.failed(message)
    };
  }
}
