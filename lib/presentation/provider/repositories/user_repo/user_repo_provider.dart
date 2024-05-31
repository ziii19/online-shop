import 'package:online_shop/data/firebase/firebase_user_repo.dart';
import 'package:online_shop/data/repositories/user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repo_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => FirebaseUserRepo();
