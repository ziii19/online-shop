import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../usecase/usecase.dart';

part 'user_data_prov.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? photoProfile,
  }) async {
    state = const AsyncLoading();

    Register register = await ref.read(registerProvider);

    var result =
        register(RegisterParam(name: name, email: email, password: password));

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);

      case Failed(:final message):
        state = AsyncError(message, StackTrace.current);
        state = const AsyncData(null);

  
    }
  }
}
