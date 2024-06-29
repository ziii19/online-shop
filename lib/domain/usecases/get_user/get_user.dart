import 'package:online_shop/domain/usecases/get_user/get_user_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

import '../../../data/repositories/user_repo.dart';
import '../../entities/result.dart';
import '../../entities/user.dart';

class GetUser implements UseCase<Result<User>, GetUserParam> {
  final UserRepository userRepository;

  GetUser({required this.userRepository});

  @override
  Future<Result<User>> call(GetUserParam params) async {
    var userResult = await userRepository.getUser(uid: params.uid);

    return switch (userResult) {
      Success(value: final user) => Result.success(user),
      Failed(:final message) => Result.failed(message)
    };
  }
}
