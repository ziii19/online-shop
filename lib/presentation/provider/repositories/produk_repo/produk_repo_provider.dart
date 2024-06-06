import '../../../../data/firebase/firebase_produk_repo.dart';
import '../../../../data/repositories/produk_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'produk_repo_provider.g.dart';

@riverpod
ProductRepo productRepo(ProductRepoRef ref) => FirebaseProdukRepo();
