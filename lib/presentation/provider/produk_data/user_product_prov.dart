import 'package:online_shop/domain/entities/entities.dart';
import 'package:online_shop/domain/usecases/get_user/get_user.dart';
import 'package:online_shop/domain/usecases/get_user/get_user_param.dart';
import 'package:online_shop/presentation/provider/usecase/get_user_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_product_prov.g.dart';

@riverpod
Future<User?> user(UserRef ref, {required String uid}) async {
  GetUser getUser = ref.read(getUserProvider);

  var result = await getUser(GetUserParam(uid: uid));

  return switch (result) {
    Success(value: final user) => user,
    Failed(message: _) => null
  };
}
