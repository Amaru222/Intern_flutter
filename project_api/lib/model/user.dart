import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String avatar;
  final Timestamp birthday;
  final String className;
  final String email;
  final String name;
  final String phone;
  final num role;
  final String uid;
  final String address;

  User(
      {required this.avatar,
      required this.birthday,
      required this.className,
      required this.email,
      required this.name,
      required this.phone,
      required this.role,
      required this.uid,
      required this.address});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      avatar: data['avatar'],
      birthday: data['birthday'] as Timestamp,
      className: data['class'],
      email: data['email'],
      name: data['name'],
      phone: data['phone'],
      role: data['role'],
      uid: data['uid'],
      address: data['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'birthday': birthday,
      'className': className,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'uid': uid,
      'address': address,
    };
  }
}
