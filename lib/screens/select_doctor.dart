// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
//import 'package:veta/screens/DashboardPages/user_scaffold.dart';
//import 'package:veta/screens/dataLoader_box.dart';
import 'package:veta/screens/signin_page.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:veta/screens/global.dart';

class SelectDoctor extends StatefulWidget {
  SelectDoctor({super.key});

  @override
  State<SelectDoctor> createState() => _SelectDoctorState();
}

class _SelectDoctorState extends State<SelectDoctor> {
  var session = SessionManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Select Doctors'),
        centerTitle: false,
      ),
      backgroundColor: defaultBackgroundColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot snap) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 317,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 62, 20, 211),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Doctor Name: " +
                                snap['firstname'].toString() +
                                " " +
                                snap['lastname'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "License Number: " +
                                snap['licenseNumber'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Phone Number: " + snap['phoneNumber'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Speciality: " + snap['speciality'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 152, 37,
                                    37), //background color of button
                                side: BorderSide(
                                    width: 3,
                                    color: Colors
                                        .deepPurple), //border width and color
                                elevation: 6, //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(
                                    30) //content padding inside button
                                ),
                            onPressed: () async {
                              // s = snap['firstname'].toString() +
                              //     " " +
                              //     snap['lastname'].toString();
                              s = snap.id;
                              Navigator.pop(context, 'Hello');
                            },
                            child: Text("Select"),
                          ),
                        ),

                        // Divider(
                        //   thickness: 3,
                        //   color: Colors.black54,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     "Status: " + snap['status'].toString(),
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 14,
                        //       backgroundColor: Colors.black54,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
