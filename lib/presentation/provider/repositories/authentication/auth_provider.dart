import '../../../../data/firebase/firebase_auth.dart';
import '../../../../data/repositories/authentication.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
Authentication authentication(AuthenticationRef ref) => FirebaseAuth();
