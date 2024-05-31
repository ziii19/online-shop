import 'package:online_shop/domain/usecases/get_logged_in_user.dart/get_loggedin_user.dart';
import 'package:online_shop/presentation/provider/repositories/authentication/auth_provider.dart';
import 'package:online_shop/presentation/provider/repositories/user_repo/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_prov.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
