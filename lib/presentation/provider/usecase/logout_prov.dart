import 'package:online_shop/domain/usecases/usecases.dart';
import 'package:online_shop/presentation/provider/repositories/authentication/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_prov.g.dart';

@riverpod
Logout logout(LogoutRef ref) =>
    Logout(authentication: ref.watch(authenticationProvider));
