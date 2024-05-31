import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:online_shop/data/repositories/authentication.dart';
import 'package:online_shop/domain/entities/result.dart';

class FirebaseAuth implements Authentication {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuth({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    try {
      var userLogin = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return Result.success(userLogin.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message!);
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();

    if (_firebaseAuth.currentUser != null) {
      return const Result.success(null);
    } else {
      return const Result.failed('Failed to Sign Out');
    }
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) async {
    try {
      var userRegister = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return Result.success(userRegister.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message!);
    }
  }

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;
}