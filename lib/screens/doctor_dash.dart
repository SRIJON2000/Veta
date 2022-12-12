// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/appointment_request.dart';
import 'package:veta/screens/class.dart';
import 'package:veta/screens/doctor_appointments.dart';
import 'package:veta/screens/petcare_form.dart';
import 'package:veta/screens/profile.dart';

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veta/screens/book_appointment.dart';
import 'package:veta/screens/doctor_details.dart';
import 'package:veta/screens/data_getter.dart';
import 'package:veta/screens/petcare_form.dart';
import 'package:veta/screens/user_notification.dart';
import 'package:veta/screens/doctor_notification.dart';
import 'package:veta/screens/notification_loader.dart';

class DoctorScaffold extends StatefulWidget {
  const DoctorScaffold({Key? key}) : super(key: key);

  @override
  State<DoctorScaffold> createState() => _DoctorScaffoldState();
}

class _DoctorScaffoldState extends State<DoctorScaffold> {
  Future onlogin() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((QuerySnapshot results) async {
      //doctor_firstname = results.docs[0]['firstname'];
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(results.docs[0].id)
          .update({
        "isLoggedin": "Online",
      });
    });
  }

  @override
  void initState() {
    onlogin();
    global_doctor.getDoctorDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text('WELCOME ${user!.email!}'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return NotificationLoader(
                  userNotification: UserNotification(),
                  doctorNotification: DoctorNotification(),
                );
              }));
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (BuildContext context) {
              //   return ProfilePage();
              // }));
            },
            icon: const Icon(Icons.person),
          ),
        ],
        centerTitle: false,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        child: Column(children: [
          DrawerHeader(
            child: ImageIcon(AssetImage('./assets/images/logo.png'), size: 160),
          ),
          //child: ImageIcon(AssetImage('assets/images/logo.png'), size: 160)),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'D A S H B O A R D',
                style: drawerTextColor,
              ),
              onTap: (() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return DoctorScaffold();
                }));
              }),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.account_box),
              title: Text(
                'M Y  A P P O I N T M E N T S',
                style: drawerTextColor,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const DoctorAppointment();
                }));
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'L O G O U T',
                style: drawerTextColor,
              ),
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection('doctors')
                    .where('email', isEqualTo: user!.email)
                    .get()
                    .then((QuerySnapshot results) async {
                  //doctor_firstname = results.docs[0]['firstname'];
                  await FirebaseFirestore.instance
                      .collection('doctors')
                      .doc(results.docs[0].id)
                      .update({
                    "isLoggedin": "Offline",
                  });
                });
                await FirebaseAuth.instance.signOut();
                Phoenix.rebirth(context);
              },
            ),
          )
        ]),
      ),
      body: GridView.count(
        padding: EdgeInsets.only(top: 20),
        mainAxisSpacing: 50,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentRequest()),
                );
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/medicalAppointment.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Appointment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Requests",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          "Check Your Appointment Requests",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorAppointment()),
                );
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/medicalAppointment.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "My",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Appointments",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          "My Appointments",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
