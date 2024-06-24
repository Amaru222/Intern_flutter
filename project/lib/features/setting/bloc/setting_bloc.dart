import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SettingBloc() : super(SettingInitial()) {
    on<SettingEvent>((event, emit) {});
    on<LoadDataSetting>(_loadDataSetting);
    _listenToSettinghange();
  }
  void _listenToSettinghange() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _firestore
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> profileData = snapshot.data()!;
          String nameUser = profileData['name'] ?? '';
          String classInfo = profileData['class'] ?? '';
          String title = profileData['title'] ?? '';
          add(SettingUpdated(nameUser, classInfo, title));
        }
      });
    }
  }

  Future<FutureOr<void>> _loadDataSetting(
      LoadDataSetting event, Emitter<SettingState> emit) async {
    try {
      User? currentUser = _auth.currentUser;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(currentUser?.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> settingData = snapshot.data()!;
        String nameUser = settingData['name'] ?? '';
        String classInfo = settingData['class'] ?? '';
        String title = settingData['title'] ?? '';
        emit(SettingLoaded(nameUser, classInfo, title));
      } else {
        emit(const SettingError('Khong tim thay thong tin nguoi dung'));
      }
    } catch (e) {
      emit(SettingError('loi khi tai thong tin $e'));
    }
  }
}
