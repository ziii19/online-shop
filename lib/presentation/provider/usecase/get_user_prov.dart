import 'package:online_shop/domain/usecases/get_user/get_user.dart';
import 'package:online_shop/presentation/provider/repositories/user_repo/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user_prov.g.dart';

@riverpod
GetUser getUser(GetUserRef ref) =>
    GetUser(userRepository: ref.watch(userRepositoryProvider));
