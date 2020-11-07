import 'package:json_annotation/json_annotation.dart';

part 'access_token_model.g.dart';

@JsonSerializable()
class AccessTokenModel {
  @JsonKey(name: 'accesss_token')
  String accesssToken;

  AccessTokenModel({
    this.accesssToken,
  });

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) => _$AccessTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenModelToJson(this);
}
