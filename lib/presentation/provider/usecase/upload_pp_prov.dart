import '../../../domain/usecases/upload_photo_profile/upload_photo_profile.dart';
import '../repositories/user_repo/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_pp_prov.g.dart';

@riverpod
UploadPhotoProfile uploadPhotoProfile(UploadPhotoProfileRef ref) =>
    UploadPhotoProfile(repository: ref.watch(userRepositoryProvider));
