import 'package:online_shop/data/repositories/authentication.dart';
import 'package:online_shop/data/repositories/user_repo.dart';
import 'package:online_shop/domain/usecases/login/login_params.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

import '../../entities/entities.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  Login(
      {required Authentication authentication,
      required UserRepository userRepository})
      : _authentication = authentication,
        _userRepository = userRepository;
  @override
  Future<Result<User>> call(LoginParams params) async {
    var idResult = await _authentication.login(
        email: params.email, password: params.password);

    if (idResult.isSuccess) {
      var userResult =
          await _userRepository.getUser(uid: idResult.resultValue!);

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message)
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
