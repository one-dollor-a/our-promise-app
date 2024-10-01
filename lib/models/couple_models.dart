import 'package:json_annotation/json_annotation.dart';

part 'couple_models.g.dart';

@JsonSerializable()
class CoupleInfoUpdateRequest {
  final String? coupleName;
  final String? coupleSince;
  final String? myNickname;
  final String? partnerNickname;

  CoupleInfoUpdateRequest(
      {this.coupleName,
      this.coupleSince,
      this.myNickname,
      this.partnerNickname});

  factory CoupleInfoUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CoupleInfoUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CoupleInfoUpdateRequestToJson(this);
}

@JsonSerializable()
class CoupleInfoResponse {
  final int coupleId;
  final String coupleName;
  final String? coupleProfileImageUrl;
  final String coupleSince;
  final int partnerMemberId;
  final String myNickname;
  final String partnerNickname;

  CoupleInfoResponse({
    required this.coupleId,
    required this.coupleName,
    this.coupleProfileImageUrl,
    required this.coupleSince,
    required this.partnerMemberId,
    required this.myNickname,
    required this.partnerNickname,
  });

  factory CoupleInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CoupleInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CoupleInfoResponseToJson(this);
}

@JsonSerializable()
class CoupleInfoSummaryResponse {
  final int coupleId;
  final String coupleName;
  final String coupleSince;

  CoupleInfoSummaryResponse({
    required this.coupleId,
    required this.coupleName,
    required this.coupleSince,
  });

  factory CoupleInfoSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$CoupleInfoSummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CoupleInfoSummaryResponseToJson(this);
}
