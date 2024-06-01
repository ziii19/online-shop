import 'package:online_shop/data/repositories/authentication.dart';
import 'package:online_shop/data/repositories/user_repo.dart';
import 'package:online_shop/domain/usecases/login/login_params.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

import '../../entities/entities.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final Authentication authentication;
  final UserRepository userRepository;

  Login({required this.authentication, required this.userRepository});
  @override
  Future<Result<User>> call(LoginParams params) async {
    var idResult = await authentication.login(
        email: params.email, password: params.password);

    if (idResult is Success) {
      var userResult = await userRepository.getUser(uid: idResult.resultValue!);

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message)
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
