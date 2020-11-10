// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookModel _$FacebookModelFromJson(Map<String, dynamic> json) {
  return FacebookModel(
    email: json['email'] as String,
    picture: FacebookModel._picutreFromJson(json['picture']),
  )..largeImage = json['largeImage'] as String;
}

Map<String, dynamic> _$FacebookModelToJson(FacebookModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'picture': instance.picture,
      'largeImage': instance.largeImage,
    };
