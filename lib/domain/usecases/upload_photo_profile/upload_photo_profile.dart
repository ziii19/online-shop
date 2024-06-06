import '../../../data/repositories/user_repo.dart';
import 'upload_photo_profile_param.dart';
import '../usecase.dart';

import '../../entities/entities.dart';

class UploadPhotoProfile implements UseCase<Result<User>, UploadPPParam> {
  final UserRepository _repository;

  UploadPhotoProfile({required UserRepository repository})
      : _repository = repository;
  @override
  Future<Result<User>> call(UploadPPParam params) =>
      _repository.uploadPP(user: params.user, imageFile: params.imageFile);
}
