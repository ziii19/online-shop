import 'dart:io';

import '../../domain/entities/result.dart';
import '../../domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? birthday,
    num? phoneNumber,
    String? photoProfile,
  });

  Future<Result<User>> getUser({required String uid});
  Future<Result<User>> updateUser({required User user});
  Future<Result<User>> uploadPP({required User user, required File imageFile});
}
