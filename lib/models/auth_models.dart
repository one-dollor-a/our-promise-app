import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class AuthSignUpRequest {
  final String userId;
  final String password;
  final String nickName;

  AuthSignUpRequest(
      {required this.userId, required this.password, required this.nickName});

  factory AuthSignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSignUpRequestToJson(this);
}

@JsonSerializable()
class AuthSignInRequest {
  final String userId;
  final String password;

  AuthSignInRequest({required this.userId, required this.password});

  factory AuthSignInRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthSignInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSignInRequestToJson(this);
}

@JsonSerializable()
class AuthSignInResponse {
  final String accessToken;

  AuthSignInResponse({required this.accessToken});

  factory AuthSignInResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthSignInResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSignInResponseToJson(this);
}
