import 'package:online_shop/data/repositories/authentication.dart';
import 'package:online_shop/data/repositories/user_repo.dart';
import 'package:online_shop/domain/usecases/register/register_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

import '../../entities/entities.dart';

class Register implements UseCase<Result<User>, RegisterParam> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  Register(
      {required Authentication authentication,
      required UserRepository userRepository})
      : _authentication = authentication,
        _userRepository = userRepository;
  @override
  Future<Result<User>> call(RegisterParam params) async {
    var result = await _authentication.register(
        email: params.email, password: params.password);

    if (result.isSuccess) {
      var userResult = await _userRepository.createUser(
        uid: result.resultValue!,
        email: params.email,
        name: params.name,
        photoProfile: params.photoProfile,
      );

      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return Result.failed(result.errorMessage!);
    }
  }
}
