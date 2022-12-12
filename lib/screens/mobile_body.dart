// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:veta/constants.dart';

import 'package:veta/screens/profile.dart';
import 'package:veta/screens/book_appointment.dart';
import 'package:veta/screens/doctor_details.dart';
import 'package:veta/screens/user_appointments.dart';
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ProfilePage();
              }));
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
                  MaterialPageRoute(
                      builder: (context) => const BookAppointment()),
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
                      "Book",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Vet Appointment",
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
                          "Book an appointment for vet consultation",
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
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/vaccination.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Vaccination",
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
                          "Get your pet vaccinated at your doorstep",
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
                  MaterialPageRoute(builder: (context) => DoctorDetails()),
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
                      "assets/images/searchDoctor.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Search Doctors",
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
                          "Search for available doctors",
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
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/grooming.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Grooming & Trainning",
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
                          "Grooming & Trainning at your doorstep",
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
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/pet-shop.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Pet Store",
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
                          "Online Store for your Pet",
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
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/contact-us.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Contact Us",
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
                          "Contact us for any query",
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
