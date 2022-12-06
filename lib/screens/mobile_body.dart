import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/petcare_form.dart';
import 'package:veta/util/my_box.dart';
import 'package:veta/util/my_tile.dart';
import 'dart:async';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:veta/screens/book_appointment.dart';
import 'package:veta/screens/doctor_details.dart';
import 'package:veta/screens/petcare_form.dart';
import 'package:veta/screens/user_appointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veta/screens/user_notification.dart';
import 'package:veta/screens/doctor_notification.dart';
import 'package:veta/screens/notification_loader.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultBackgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text('WELCOME ${user!.email!}'),
          actions: [
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
            )
          ],
          centerTitle: false,
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey[300],
          child: Column(children: [
            DrawerHeader(
              child: ImageIcon(AssetImage('assets/images/logo.png'), size: 160),
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
                    return const MobileScaffold();
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
                    return UserAppointment();
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
                  await FirebaseAuth.instance.signOut();
                  //Phoenix.rebirth(context);
                },
              ),
            )
          ]),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                color: Colors.deepPurple,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 152, 37, 37), //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.deepPurple), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookAppointment()),
                      );
                    },
                    child: Text("Book An Appointment"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                color: Colors.deepPurple,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 152, 37, 37), //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.deepPurple), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetails()),
                      );
                    },
                    child: Text("Search For Doctor"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                color: Colors.deepPurple,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 152, 37, 37), //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.deepPurple), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PetCareForm()),
                      );
                    },
                    child: Text("Book Petcare Personnel"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                color: Colors.deepPurple,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 152, 37, 37), //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.deepPurple), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: null,
                    child: Text("Buy Food Supplement"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        )));
  }
}
