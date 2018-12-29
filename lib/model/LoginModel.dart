import 'package:json_annotation/json_annotation.dart';
import 'package:gankflutter/model/RootModel.dart';
import 'package:gankflutter/model/LoginDetailModel.dart';

part 'LoginModel.g.dart';

@JsonSerializable()
class LoginModel extends RootModel<LoginDetailModel>{
  LoginModel(LoginDetailModel data,int errorCode,String errorMsg):super(data,errorCode,errorMsg);

  factory LoginModel.fromJson(Map<String,dynamic> json) => _$LoginModelFromJson(json);

  toJson() => _$LoginModelToJson(this);
}