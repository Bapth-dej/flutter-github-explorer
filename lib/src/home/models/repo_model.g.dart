// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoModel _$RepoModelFromJson(Map<String, dynamic> json) {
  return RepoModel(json['name'] as String, json['description'] as String,
      DateTime.parse(json['created_at'] as String), json['language'] as String);
}

Map<String, dynamic> _$RepoModelToJson(RepoModel instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'language': instance.language
    };
