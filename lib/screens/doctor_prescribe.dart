import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';

import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart'; // For Calendor

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:veta/constants.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

class DoctorPrescribe extends StatefulWidget {
  final String appointmentid;
  const DoctorPrescribe({Key? key, required this.appointmentid})
      : super(key: key);

  @override
  State<DoctorPrescribe> createState() => _DoctorPrescribeState();
}

class _DoctorPrescribeState extends State<DoctorPrescribe> {
  TextEditingController medicine = TextEditingController();
  TextEditingController instruction = TextEditingController();

  final _formMedicineKey = GlobalKey<FormState>();
  final _formInstructionKey = GlobalKey<FormState>();

  Future book() async {
    if (_formMedicineKey.currentState!.validate() &&
        _formInstructionKey.currentState!.validate()) {
      prescribe();
    }
  }

  Future prescribe() async {
    await FirebaseFirestore.instance.collection('prescriptions').add({
      'appointment_id': widget.appointmentid,
      'medicine': medicine.text.trim(),
      'instruction': instruction.text.trim(),
    });
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(widget.appointmentid)
        .update({
      "status": "Completed",
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Presccribe"),
        backgroundColor: Colors.black54, //background color of app bar
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hello again Message!
                Text(
                  'THANK YOU',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Prescribe your details!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 25),

                Text(
                  'Medicine details',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formMedicineKey,
                    child: TextFormField(
                      maxLines: 6,
                      controller: medicine,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Enter medicine details',
                        contentPadding: const EdgeInsets.all(12.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (breed) {
                        if (breed == null || breed.isEmpty) {
                          return 'Please medicine details';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Instruction details',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formInstructionKey,
                    child: TextFormField(
                      maxLines: 6,
                      controller: instruction,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Enter instruction details',
                        contentPadding: const EdgeInsets.all(12.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (breed) {
                        if (breed == null || breed.isEmpty) {
                          return 'Please enter instructions';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                SizedBox(height: 5),
                Text(
                  '  Note:- Once you submit prescription the appointment will be completed',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: book,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Prescribe',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
