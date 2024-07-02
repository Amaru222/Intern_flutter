import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/attendance/ui/attendance_screen.dart';
import 'package:project/features/auth/changePassword/ui/change_password.dart';
import 'package:project/features/auth/initialScreen/initial_screen.dart';
import 'package:project/features/auth/login/ui/login_screen.dart';
import 'package:project/features/comment/ui/review_screen.dart';
import 'package:project/features/home/ui/home_screen.dart';
import 'package:project/features/message/ui/message_screen.dart';
import 'package:project/features/profile/ui/profile.dart';
import 'package:project/features/setting/ui/setting_screen.dart';
import 'package:project/routes/app_route_constants.dart';

class MyAppRoute {
  late final GoRouter router =
      GoRouter(initialLocation: '/', routes: <RouteBase>[
    GoRoute(
        name: MyAppRouteName.initialRouteName,
        path: MyAppRoutePath.initialRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: InitialScreen());
        }),
    GoRoute(
        name: MyAppRouteName.loginRouteName,
        path: MyAppRoutePath.loginRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        }),
    GoRoute(
        name: MyAppRouteName.homeRouteName,
        path: MyAppRoutePath.homeRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ReviewScreen());
        }),
    GoRoute(
        name: MyAppRouteName.messageRouteName,
        path: MyAppRoutePath.messageRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: MessageScreen());
        }),
    GoRoute(
        name: MyAppRouteName.settingRouteName,
        path: MyAppRoutePath.settingRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SettingScreen());
        }),
    GoRoute(
        name: MyAppRouteName.attendanceRouteName,
        path: MyAppRoutePath.attendanceRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: AttendanceScreen());
        }),
    GoRoute(
        name: MyAppRouteName.profileRouteName,
        path: MyAppRoutePath.profileRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: Profile());
        }),
    GoRoute(
        name: MyAppRouteName.changePasswordRouteName,
        path: MyAppRoutePath.changePasswordRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ChangePassword());
        }),
    GoRoute(
        name: MyAppRouteName.commentRouteName,
        path: MyAppRoutePath.commentRoutePath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ReviewScreen());
        }),
  ]);
}
