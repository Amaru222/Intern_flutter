import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserRepository {
  final FirebaseFirestore firestore;
  final auth.FirebaseAuth firebaseAuth;
  UserRepository({required this.firestore, required this.firebaseAuth});

  Future<String?> getCurrentUserUid() async {
    final user = firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<User?> fetchUserByUid(String uid) async {
    final snapshot = await firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return User.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<List<User>> fetchStudentsInClass(String className) async {
    final snapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 2)
        .where('class', isEqualTo: className)
        .get();
    return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
  }
}
