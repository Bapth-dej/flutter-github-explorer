// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(json['avatar_url'] as String, json['bio'] as String,
      json['name'] as String, json['login'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'avatar_url': instance.avatarUrl,
      'name': instance.name,
      'login': instance.login,
      'bio': instance.bio
    };
