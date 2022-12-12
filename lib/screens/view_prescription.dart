// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/data_getter.dart';
import 'package:veta/screens/user_appointments.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:veta/screens/select_doctor.dart';
import 'package:veta/screens/global.dart';

class PrescriptionView extends StatefulWidget {
  final String appointmentid;
  final String dname;
  const PrescriptionView(
      {Key? key, required this.appointmentid, required this.dname})
      : super(key: key);

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
  Future getprescriptiondetails() async {
    await FirebaseFirestore.instance
        .collection('prescriptions')
        .where('appointment_id', isEqualTo: widget.appointmentid)
        .get()
        .then((QuerySnapshot results) async {
      //mediicne = results.docs[0].id;
      setState(() {
        medicine = results.docs[0]["medicine"].toString();
        instruction = results.docs[0]["instruction"].toString();
      });
    });
  }

  @override
  void initState() {
    medicine = "";
    instruction = "";
    getprescriptiondetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Prescribed By Dr. " + widget.dname),
        backgroundColor: Colors.grey[900], //background color of app bar
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hello again Message!
                Text(
                  'Wish your pet get cured early',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Check your prescription details',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text("Medicine Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      )),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text('$medicine',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text("Instruction",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      )),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text('$instruction',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
