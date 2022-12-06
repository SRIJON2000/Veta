// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veta/screens/data_getter.dart';
import 'package:veta/screens/doctor_dash.dart';

class NotificationLoader extends StatelessWidget {
  const NotificationLoader(
      {super.key,
      required this.userNotification,
      required this.doctorNotification});

  final Widget userNotification;
  final Widget doctorNotification;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser_type(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (type == 'User') {
              return userNotification;
            } else {
              return doctorNotification;
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
