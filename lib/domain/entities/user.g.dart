// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      birthday: json['birthday'] as String?,
      phoneNumber: json['phoneNumber'] as num?,
      product: (json['product'] as num?)?.toInt() ?? 0,
      photoProfile: json['photoProfile'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'birthday': instance.birthday,
      'phoneNumber': instance.phoneNumber,
      'product': instance.product,
      'photoProfile': instance.photoProfile,
    };
