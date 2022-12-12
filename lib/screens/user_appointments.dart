// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_element, unused_local_variable, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/agora_call.dart';
import 'package:veta/screens/mobile_body.dart';
import 'package:veta/screens/view_prescription.dart';

class UserAppointment extends StatefulWidget {
  const UserAppointment({super.key});

  @override
  State<UserAppointment> createState() => _UserAppointmentState();
}

class _UserAppointmentState extends State<UserAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        backgroundColor: defaultBackgroundColor,
        drawer: Drawer(
          backgroundColor: Colors.grey[300],
          child: Column(children: [
            DrawerHeader(
              child:
                  ImageIcon(AssetImage('./assets/images/logo.png'), size: 160),
            ),
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
                    return MobileScaffold();
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
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
              body: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  child: Text("Pending",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      )),
                ),
                Tab(
                  child: Text("Upcoming",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      )),
                ),
                Tab(
                  child: Text("Completed",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      )),
                )
              ]),
              Expanded(
                  child: TabBarView(
                children: [
                  //tab 1
                  Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('requests')
                            .where('useremail', isEqualTo: user!.email)
                            .where('status', whereIn: ["Pending", "Denied"])
                            //.where('status', isEqualTo: "Denied")
                            // .orderBy('date', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView(
                            children: snapshot.data!.docs.map((snap) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[900],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Your prefer date : ",
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              snap["date"].toString(),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Your prefer time : ",
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              snap['time'],
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
                                          child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        content: Container(
                                                            height: 250,
                                                            child: Column(
                                                              children: [
                                                                Text("Pet: " +
                                                                    snap['pet_type']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Breed: " +
                                                                    snap['breed']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Height: " +
                                                                    snap['height']
                                                                        .toString() +
                                                                    " feet"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Weight: " +
                                                                    snap['weight']
                                                                        .toString() +
                                                                    " kg"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Age: " +
                                                                    snap['age']
                                                                        .toString() +
                                                                    " years"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Gender: " +
                                                                    snap['gender']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                ElevatedButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          true), // passing true
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            )));
                                                  },
                                                );
                                              },
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/images/details.png'),
                                                      height: 22,
                                                      width: 22,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text('Pet Details',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ))),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/veterinary.png'),
                                              height: 22,
                                              width: 22,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              snap["doctorname"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (snap["status"] == "Denied") ...[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "This appointment request has been denied by doctor",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 10),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Get Refund",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                  //tab 2
                  Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('requests')
                            .where('useremail', isEqualTo: user!.email)
                            .where('status', isEqualTo: "Upcoming")
                            //.orderBy('date', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView(
                            children: snapshot.data!.docs.map((snap) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[900],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/dateV.png'),
                                                  height: 22,
                                                  width: 22,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  snap["prefer_date"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/timeV.png'),
                                                  height: 22,
                                                  width: 22,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  snap['prefer_time'],
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
                                      SizedBox(height: 5),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        content: Container(
                                                            height: 250,
                                                            child: Column(
                                                              children: [
                                                                Text("Pet: " +
                                                                    snap['pet_type']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Breed: " +
                                                                    snap['breed']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Height: " +
                                                                    snap['height']
                                                                        .toString() +
                                                                    " feet"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Weight: " +
                                                                    snap['weight']
                                                                        .toString() +
                                                                    " kg"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Age: " +
                                                                    snap['age']
                                                                        .toString() +
                                                                    ' years'),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Gender: " +
                                                                    snap['gender']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                ElevatedButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          true), // passing true
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            )));
                                                  },
                                                );
                                              },
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/images/details.png'),
                                                      height: 22,
                                                      width: 22,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text('Pet Details',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ))),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/veterinary.png'),
                                              height: 22,
                                              width: 22,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              snap["doctorname"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                          ),
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context,
                                            //   // Create the SelectionScreen in the next step.
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           const AgoraCall()),
                                            // );
                                          },
                                          child: Text(
                                            "Start Video Call",
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
                  ),
                  //tab 3
                  Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('requests')
                            .where('useremail', isEqualTo: user!.email)
                            .where('status', isEqualTo: "Completed")
                            //.orderBy('date', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView(
                            children: snapshot.data!.docs.map((snap) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[900],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/dateV.png'),
                                                  height: 22,
                                                  width: 22,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  snap["prefer_date"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/timeV.png'),
                                                  height: 22,
                                                  width: 22,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  snap['prefer_time'],
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
                                      SizedBox(height: 10),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        content: Container(
                                                            height: 250,
                                                            child: Column(
                                                              children: [
                                                                Text("Pet: " +
                                                                    snap['pet_type']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Breed: " +
                                                                    snap['breed']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Height: " +
                                                                    snap['height']
                                                                        .toString() +
                                                                    " feet"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Weight: " +
                                                                    snap['weight']
                                                                        .toString() +
                                                                    " kg"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Age: " +
                                                                    snap['age']
                                                                        .toString() +
                                                                    " years"),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text("Gender: " +
                                                                    snap['gender']
                                                                        .toString()),
                                                                SizedBox(
                                                                    height: 10),
                                                                ElevatedButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          true), // passing true
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            )));
                                                  },
                                                );
                                              },
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/images/details.png'),
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text('Pet Details',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ))),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/veterinary.png'),
                                              height: 20,
                                              width: 20,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              snap["doctorname"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              // Create the SelectionScreen in the next step.
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrescriptionView(
                                                          appointmentid:
                                                              snap.id,
                                                          dname: snap[
                                                              "doctorname"])),
                                            );
                                          },
                                          child: Text(
                                            "See Prescription",
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
                  ),
                ],
              ))
            ],
          )),
        ));
  }
}
