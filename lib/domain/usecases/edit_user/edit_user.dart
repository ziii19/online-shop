import 'package:online_shop/data/repositories/user_repo.dart';
import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/edit_user/edit_user_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

class EditUser implements UseCase<Result<void>, EditUserParam> {
  final UserRepository _userRepository;

  EditUser({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<void>> call(EditUserParam params) async {
    var result = await _userRepository.updateUser(user: params.user);

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message)
    };
  }
}
