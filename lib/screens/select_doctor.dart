// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:veta/constants.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:veta/screens/global.dart';

class SelectDoctor extends StatefulWidget {
  const SelectDoctor({super.key});

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
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.docs.map((DocumentSnapshot snap) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[900],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/veterinary.png'),
                                        height: 22,
                                        width: 22,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        snap['firstname'].toString() +
                                            " " +
                                            snap['lastname'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/license.png'),
                                        height: 22,
                                        width: 22,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        snap['licenseNumber'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/phone-call.png'),
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: (() async {
                                          await FlutterPhoneDirectCaller
                                              .callNumber(snap['phoneNumber']
                                                  .toString());
                                        }),
                                        child: Text(
                                          snap['phoneNumber'].toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/badge.png'),
                                        height: 22,
                                        width: 22,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        snap['speciality'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                            ),
                            onPressed: () {
                              doctorid = snap['email'].toString();
                              doctorname = snap['firstname'].toString() +
                                  " " +
                                  snap['lastname'].toString();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Select",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
