// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veta/screens/data_getter.dart';
import 'package:veta/screens/doctor_dash.dart';

class DashboardLoader extends StatelessWidget {
  const DashboardLoader(
      {super.key, required this.userScaffold, required this.doctorScaffold});

  final Widget userScaffold;
  final Widget doctorScaffold;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser_type(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (type == 'User') {
              return userScaffold;
            } else {
              return doctorScaffold;
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
