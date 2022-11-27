import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veta/screens/auth_page.dart';
import 'package:veta/screens/mobile_body.dart';
import 'package:veta/screens/responsive_layout.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class CheckLoginStatus extends StatelessWidget {
  const CheckLoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return ResponsiveLayout(
            //   mobileBody: MobileScaffold(),
            //   desktopBody: DesktopScaffold(),
            //   tabletBody: TabletScaffold(),
            // );
            // return const MobileDriver();
            //return const HomePage();
            // return const DesktopScaffold();
            return const MobileScaffold();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
