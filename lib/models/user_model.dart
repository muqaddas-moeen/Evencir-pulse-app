import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? userType;
  DateTime? createdAt;
  String? profilePic;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.userType,
    this.createdAt,
    this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userType': userType,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      userType: map['userType'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      profilePic: map['profilePic'],
    );
  }
}
