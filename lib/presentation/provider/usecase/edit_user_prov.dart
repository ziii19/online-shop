import 'package:online_shop/domain/usecases/edit_user/edit_user.dart';
import 'package:online_shop/presentation/provider/repositories/user_repo/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_user_prov.g.dart';

@riverpod
EditUser editUser(EditUserRef ref) =>
    EditUser(userRepository: ref.watch(userRepositoryProvider));
