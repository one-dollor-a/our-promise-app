import 'dart:convert';

CoupleProfile coupleProfileFromJson(String str) =>
    CoupleProfile.fromJson(json.decode(str));

String coupleProfileToJson(CoupleProfile data) => json.encode(data.toJson());

class CoupleProfile {
  int? id;
  String? name;
  DateTime? firstDate;
  String? get dDay => firstDate != null
      ? 'D+${DateTime.now().difference(firstDate!).inDays}'
      : null;

  CoupleProfile({
    this.id,
    this.name,
    this.firstDate,
  });

  factory CoupleProfile.fromJson(Map<String, dynamic> json) => CoupleProfile(
        id: json["id"],
        name: json["name"],
        firstDate: json["firstDate"] != null
            ? DateTime.parse(json["firstDate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstDate": firstDate != null
            ? "${firstDate!.year.toString().padLeft(4, '0')}-${firstDate!.month.toString().padLeft(2, '0')}-${firstDate!.day.toString().padLeft(2, '0')}"
            : null
      };
}
