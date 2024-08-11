import 'package:intl/intl.dart';

enum Gender { MALE, FEMALE }

class User {
  final String? id;
  final String? nickName;
  final Gender? gender;
  final String? bloodType;
  final int? shoeSize;
  final int? height;
  final int? weight;
  final DateTime? birthday;

  User({
    required this.id,
    required this.nickName,
    required this.gender,
    required this.bloodType,
    required this.shoeSize,
    required this.height,
    required this.weight,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickName': nickName,
      'gender': gender,
      'bloodType': bloodType,
      'shoeSize': shoeSize,
      'height': height,
      'weight': weight,
      'birthday': birthday?.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickName: json['nickName'],
      gender: json['gender'],
      bloodType: json['bloodType'],
      shoeSize: json['shoeSize'],
      height: json['height'],
      weight: json['weight'],
      birthday: json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
    );
  }
}