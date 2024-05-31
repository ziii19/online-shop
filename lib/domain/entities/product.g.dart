// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      uid: json['uid'] as String,
      id: json['id'] as String,
      nameProduct: json['nameProduct'] as String,
      price: (json['price'] as num).toInt(),
      desc: json['desc'] as String,
      imgProduct: json['imgProduct'] as String,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'nameProduct': instance.nameProduct,
      'price': instance.price,
      'desc': instance.desc,
      'imgProduct': instance.imgProduct,
    };
