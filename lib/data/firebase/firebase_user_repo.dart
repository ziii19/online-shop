import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/user_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/entities/result.dart';
import '../../domain/entities/user.dart';
import 'package:path/path.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? birthday,
      num? phoneNumber,
      String? photoProfile}) async {
    CollectionReference<Map<String, dynamic>> reference =
        _firebaseFirestore.collection('users');

    await reference.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'photoProfile': photoProfile,
    });

    DocumentSnapshot<Map<String, dynamic>> result =
        await reference.doc(uid).get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('Failed to create account');
    }
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> reference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result = await reference.get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('User not found!');
    }
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    try {
      DocumentReference<Map<String, dynamic>> users =
          _firebaseFirestore.doc('users/${user.uid}');
      await users.update(user.toJson());

      DocumentSnapshot<Map<String, dynamic>> result = await users.get();

      if (result.exists) {
        User updateUser = User.fromJson(result.data()!);

        if (updateUser == user) {
          return Result.success(updateUser);
        } else {
          return const Result.failed('Failed to update user data');
        }
      } else {
        return const Result.failed('Failed to update user data');
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Failed to update user data');
    }
  }

  @override
  Future<Result<User>> uploadPP(
      {required User user, required File imageFile}) async {
    String filename = basename(imageFile.path);

    Reference reference = FirebaseStorage.instance.ref().child(filename);

    try {
      if (user.photoProfile != null && user.photoProfile!.isNotEmpty) {
        Reference oldImage =
            FirebaseStorage.instance.refFromURL(user.photoProfile!);
        oldImage.delete();
      }

      await reference.putFile(imageFile);

      String downloadUrl = await reference.getDownloadURL();

      var updateResult =
          await updateUser(user: user.copyWith(photoProfile: downloadUrl));

      if (updateResult.isSuccess) {
        return Result.success(updateResult.resultValue!);
      } else {
        return Result.failed(updateResult.errorMessage!);
      }
    } catch (e) {
      return const Result.failed('Failed to upload profile picture');
    }
  }
}
