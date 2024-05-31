import 'package:online_shop/data/repositories/authentication.dart';
import 'package:online_shop/domain/entities/result.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;
  @override
  Future<Result<void>> call(void _) => _authentication.logout();
}
