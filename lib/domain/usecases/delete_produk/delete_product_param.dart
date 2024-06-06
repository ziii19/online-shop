import 'package:online_shop/domain/entities/entities.dart';

class DeleteProductParam {
  final String id;
  final Product product;

  DeleteProductParam({required this.product, required this.id});
}
