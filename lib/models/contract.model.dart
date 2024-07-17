import 'dart:convert';

Contract contractFromJson(String str) => Contract.fromJson(json.decode(str));

String contractToJson(Contract data) => json.encode(data.toJson());

class Contract {
  int id;
  String body;
  DateTime createdAt;
  int writerId;

  Contract({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.writerId,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        writerId: json["writerId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "createdAt": createdAt.toIso8601String(),
        "writerId": writerId,
      };
}
