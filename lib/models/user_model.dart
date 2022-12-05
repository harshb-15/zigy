import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? email, first_name, last_name, avatar;

  User({
    this.id,
    this.avatar,
    this.email,
    this.first_name,
    this.last_name,
  });

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
