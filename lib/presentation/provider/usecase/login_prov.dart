import 'package:online_shop/domain/usecases/usecases.dart';
import 'package:online_shop/presentation/provider/repositories/authentication/auth_provider.dart';
import 'package:online_shop/presentation/provider/repositories/user_repo/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_prov.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
