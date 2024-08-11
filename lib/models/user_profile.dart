import 'package:intl/intl.dart';

enum Gender { MALE, FEMALE }

/// 멤버 기본정보
class UserProfile {
  final String nickName;
  final Gender? gender;
  final DateTime? birthday;
  final int? height;
  final int? weight;
  final String? bloodType;
  final int? shoeSize;

  UserProfile({
    required this.nickName,
    required this.gender,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.shoeSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickName': nickName,
      'gender': gender.toString().split('.').last,
      'birthday': birthday?.toIso8601String(),
      'height': height,
      'weight': weight,
      'bloodType': bloodType,
      'shoeSize': shoeSize,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      nickName: json['nickName'],
      gender: json['gender'],
      birthday: json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      height: json['height'],
      weight: json['weight'],
      bloodType: json['bloodType'],
      shoeSize: json['shoeSize'],
    );
  }
}