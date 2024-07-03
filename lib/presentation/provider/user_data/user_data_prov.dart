import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_shop/presentation/provider/produk_data/produk_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/get_logged_in_user.dart/get_loggedin_user.dart';
import '../../../domain/usecases/login/login.dart';
import '../../../domain/usecases/login/login_params.dart';
import '../../../domain/usecases/logout/logout.dart';
import '../../../domain/usecases/register/register.dart';
import '../../../domain/usecases/register/register_param.dart';
import '../../../domain/usecases/upload_photo_profile/upload_photo_profile.dart';
import '../../../domain/usecases/upload_photo_profile/upload_photo_profile_param.dart';
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
        ref.read(produkDataProvider);
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

  Future<void> uploadPP({required User user, required File imageFile}) async {
    UploadPhotoProfile uploadPP = ref.read(uploadPhotoProfileProvider);

    var result =
        await uploadPP(UploadPPParam(imageFile: imageFile, user: user));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
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
