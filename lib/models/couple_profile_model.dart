import 'dart:convert';

CoupleProfile coupleProfileFromJson(String str) =>
    CoupleProfile.fromJson(json.decode(str));

String coupleProfileToJson(CoupleProfile data) => json.encode(data.toJson());

class CoupleProfile {
  int coupleId;
  String coupleName;
  String coupleProfileImageUrl;
  DateTime coupleSince;
  int partnerMemberId;
  String myNickname;
  String partnerNickname;

  String get dDay => 'D+${DateTime.now().difference(coupleSince).inDays}';

  CoupleProfile({
    required this.coupleId,
    required this.coupleName,
    required this.coupleProfileImageUrl,
    required this.coupleSince,
    required this.partnerMemberId,
    required this.myNickname,
    required this.partnerNickname,
  });

  factory CoupleProfile.fromJson(Map<String, dynamic> json) => CoupleProfile(
        coupleId: json["coupleId"],
        coupleName: json["coupleName"],
        coupleProfileImageUrl: json["coupleProfileImageUrl"],
        coupleSince: DateTime.parse(json["coupleSince"]),
        partnerMemberId: json["partnerMemberId"],
        myNickname: json["myNickname"],
        partnerNickname: json["partnerNickname"],
      );

  Map<String, dynamic> toJson() => {
        "coupleId": coupleId,
        "coupleName": coupleName,
        "coupleProfileImageUrl": coupleProfileImageUrl,
        "coupleSince":
            "${coupleSince.year.toString().padLeft(4, '0')}-${coupleSince.month.toString().padLeft(2, '0')}-${coupleSince.day.toString().padLeft(2, '0')}",
        "partnerMemberId": partnerMemberId,
        "myNickname": myNickname,
        "partnerNickname": partnerNickname
      };
}

// {
// "coupleId": 1,
// "coupleName": "오구오구",
// "coupleProfileImageUrl": "image/path.jpg",
// "coupleSince": "2024-05-09",
// "partnerMemberId": 59,
// "myNickname": "오구",
// "partnerNickname": "아기 오구"
// }
