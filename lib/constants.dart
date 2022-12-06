// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:veta/screens/auth_page.dart';
import 'package:veta/screens/mobile_body.dart';
import 'package:veta/screens/user_appointments.dart';
// import 'package:veta/screens/notification_loader.dart';
// import 'package:veta/screens/user_notification.dart';
// import 'package:veta/screens/doctor_notification.dart';

final user = FirebaseAuth.instance.currentUser;
// String usertype = "";
// String name = "";
// Future gettype() async {
//   await FirebaseFirestore.instance
//       .collection('userType')
//       .where('email', isEqualTo: user!.email)
//       .get()
//       .then((QuerySnapshot results) async {
//     usertype = results.docs[0]['type'];
//   });
// }

// Future loadname() async {
//   if (usertype == "User") {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: user!.email)
//         .get()
//         .then((QuerySnapshot results) async {
//       name = results.docs[0]['firstname'].toString() +
//           results.docs[0]['lastname'].toString();
//     });
//   } else {
//     await FirebaseFirestore.instance
//         .collection('doctors')
//         .where('email', isEqualTo: user!.email)
//         .get()
//         .then((QuerySnapshot results) async {
//       name = results.docs[0]['firstname'].toString() +
//           results.docs[0]['lastname'].toString();
//     });
//   }
// }

// @override
// void initState() {
//   gettype();
//   loadname();
//   print(name);
// }

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text('WELCOME ${user!.email!}'),
  actions: [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.notifications),
    )
  ],
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      DrawerHeader(

          child: ImageIcon(AssetImage('assets/images/logo.png'), size: 260)),

      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'D A S H B O A R D',
            style: drawerTextColor,
          ),
          onTap: () {
            Widget build(BuildContext context) {
              return Scaffold(
                body: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //return const HomePage();

                      return const MobileScaffold();
                    } else {
                      return const AuthPage();
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'M Y  A P P O I N T M E N T S',
              style: drawerTextColor,
            ),
            onTap: () {
              // Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) {
              //   return const UserAppointment();
              // }));
              Widget build(BuildContext context) {
                return Scaffold(
                  body: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      return const UserAppointment();
                    },
                  ),
                );
              }
            }),
      ),
      // Padding(
      //   padding: tilePadding,
      //   child: ListTile(
      //     leading: Icon(Icons.info),
      //     title: Text(
      //       'S E T T I N G S',
      //       style: drawerTextColor,
      //     ),
      //     onTap: () {
      //       FirebaseAuth.instance.signOut();
      //     },
      //   ),
      // ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ),
    ],
  ),
);
