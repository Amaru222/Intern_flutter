import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/attendance/ui/attendance_screen.dart';
import 'package:project/features/auth/changePassword/ui/change_password.dart';
import 'package:project/features/auth/login/ui/login_screen.dart';
import 'package:project/features/home/ui/home_screen.dart';
import 'package:project/features/message/ui/message_screen.dart';
import 'package:project/features/profile/ui/profile.dart';
import 'package:project/features/setting/ui/setting_screen.dart';
import 'package:project/routes/app_route_constants.dart';

class MyAppRoute {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isAuthenticated() {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  late final GoRouter router = GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final isLoggedIn = isAuthenticated();
        final isLoggingIn = state.uri.toString() == '/';

        if (!isLoggedIn && !isLoggingIn) {
          return '/';
        }
        if (isLoggedIn && isLoggingIn) {
          return '/home';
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
            name: MyAppRouteConstants.loginRouteName,
            path: '/',
            pageBuilder: (context, state) {
              return const MaterialPage(child: LoginScreen());
            }),
        GoRoute(
            name: MyAppRouteConstants.homeRouteName,
            path: '/home',
            pageBuilder: (context, state) {
              return const MaterialPage(child: HomeScreen());
            }),
        GoRoute(
            name: MyAppRouteConstants.messageRouteName,
            path: '/message',
            pageBuilder: (context, state) {
              return const MaterialPage(child: MessageScreen());
            }),
        GoRoute(
            name: MyAppRouteConstants.settingRouteName,
            path: '/setting',
            pageBuilder: (context, state) {
              return const MaterialPage(child: SettingScreen());
            }),
        GoRoute(
            name: MyAppRouteConstants.attendanceRouteName,
            path: '/attendance',
            pageBuilder: (context, state) {
              return const MaterialPage(child: AttendanceScreen());
            }),
        GoRoute(
            name: MyAppRouteConstants.profileRouteName,
            path: '/setting/profile',
            pageBuilder: (context, state) {
              return const MaterialPage(child: Profile());
            }),
        GoRoute(
            name: MyAppRouteConstants.changePasswordRouteName,
            path: '/setting/changepassword',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ChangePassword());
            }),
      ]);
}
