import 'package:online_shop/data/repositories/user_repo.dart';
import 'package:online_shop/domain/usecases/upload_photo_profile/upload_photo_profile_param.dart';
import 'package:online_shop/domain/usecases/usecase.dart';

import '../../entities/entities.dart';

class UploadPhotoProfile implements UseCase<Result<User>, UploadPPParam> {
  final UserRepository _repository;

  UploadPhotoProfile({required UserRepository repository})
      : _repository = repository;
  @override
  Future<Result<User>> call(UploadPPParam params) =>
      _repository.uploadPP(user: params.user, imageFile: params.imageFile);
}
