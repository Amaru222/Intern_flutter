import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LoadDataProfile>(_loadDataProfile);
    _listenToProfileChange();
  }
  void _listenToProfileChange() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _firestore
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> profileData = snapshot.data()!;
          List<Map<String, dynamic>> profileItems = [
            {
              'field': 'Ngày sinh',
              'data': profileData['birthday'] != null
                  ? formatDate((profileData['birthday'] as Timestamp).toDate())
                  : '',
              'onTap': () {},
            },
            {
              'field': 'Email',
              'data': profileData['email'] ?? '',
              'onTap': () {},
            },
            {
              'field': 'Số điện thoại',
              'data': profileData['phone'] ?? '',
              'onTap': () {},
            },
            {
              'field': 'Địa chỉ',
              'data': profileData['address'] ?? '',
              'onTap': () {},
            },
          ];
          String nameUser = profileData['name'] ?? '';
          String classInfo = profileData['class'] ?? '';
          String title = profileData['title'] ?? '';
          add(ProfileUpdated(profileItems, nameUser, classInfo, title));
        }
      });
    }
  }

  Future<FutureOr<void>> _loadDataProfile(
      LoadDataProfile event, Emitter<ProfileState> emit) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        emit(const ProfileError('chua dang nhap'));
      }
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(currentUser?.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> profileData = snapshot.data()!;
        List<Map<String, dynamic>> profileItems = [
          {
            'field': 'Ngày sinh',
            'data': profileData['birthday'] != null
                ? formatDate((profileData['birthday'] as Timestamp).toDate())
                : '',
            'onTap': () {},
          },
          {
            'field': 'Email',
            'data': profileData['email'] ?? '',
            'onTap': () {},
          },
          {
            'field': 'Số điện thoại',
            'data': profileData['phone'] ?? '',
            'onTap': () {},
          },
          {
            'field': 'Địa chỉ',
            'data': profileData['address'] ?? '',
            'onTap': () {},
          },
        ];
        String nameUser = profileData['name'] ?? '';
        String classInfo = profileData['class'] ?? '';
        String title = profileData['title'] ?? '';
        emit(ProfileLoaded(profileItems, nameUser, classInfo, title));
      } else {
        emit(const ProfileError('Khong tim thay thong tin nguoi dung'));
      }
    } catch (e) {
      emit(ProfileError('loi khi tai thong tin: $e'));
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
