import 'dart:io';

import 'package:flutter/material.dart';
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
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    Register register = await ref.read(registerProvider);

    var result = await register(
        RegisterParam(name: name, email: email, password: password));

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);

        break;
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<Result<User>> uploadPP(
      {required User user, required File imageFile}) async {
    UploadPhotoProfile uploadPP = ref.read(uploadPhotoProfileProvider);

    return await uploadPP(UploadPPParam(imageFile: imageFile, user: user));
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var result = await getLoggedInUser(null);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    Logout logout = ref.read(logoutProvider);

    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }
}
