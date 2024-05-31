import 'package:online_shop/domain/usecases/register/register.dart';
import 'package:online_shop/presentation/provider/repositories/authentication/auth_provider.dart';
import 'package:online_shop/presentation/provider/repositories/user_repo/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_prov.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
