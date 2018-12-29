import 'package:json_annotation/json_annotation.dart';

part 'LoginDetailModel.g.dart';

@JsonSerializable()
class LoginDetailModel {
  List<String> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;

  LoginDetailModel(this.chapterTops, this.collectIds, this.email, this.icon,
      this.id, this.password, this.token, this.type, this.username);

  factory LoginDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDetailModelFromJson(json);

  toJson() => _$LoginDetailModelToJson(this);
}
