// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/mobile_body.dart';
import 'package:veta/screens/doctor_dash.dart';

// Getting users Table Data

late String medicine = '';
late String instruction = '';
late String user_firstname = '',
    user_phoneNumber = '',
    user_lastname = '',
    user_email = '';
late String doctor_firstname = '',
    doctor_phoneNumber = '',
    doctor_lastname = '',
    doctor_email = '';

Future getUser_info(email) async {
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot results) {
    user_firstname = results.docs[0]['firstname'];
    user_phoneNumber = results.docs[0]['phoneNumber'];
    user_lastname = results.docs[0]['lastname'];
  });
}

Future getDoctor_info(email) async {
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot results) {
    doctor_firstname = results.docs[0]['firstname'];
    doctor_phoneNumber = results.docs[0]['phoneNumber'];
    doctor_lastname = results.docs[0]['lastname'];
    //print(results.docs[0]['phoneNumber']);
  });
}

// Getting user type

String type = '';
String email = user!.email.toString();
Future getUser_type() async {
  await FirebaseFirestore.instance
      .collection('userType')
      .where('email', isEqualTo: user!.email)
      .get()
      .then((results) {
    type = results.docs[0]['type'];
    //email = user!.email.toString();
  });
}

class Member {
  String email = "";
  String firstname = "";
  String lastname = "";
  String phoneNumber = "";
  String isLoggedin = "";
}

class User extends Member {
  void Signup() {}
  void bookappointment() {}
  void searchdoctor() {}
  void bookpetcare() {}
}

class Doctor extends Member {
  void Signup() {}
  void approveappointment() {}
  void providetime() {}
  void checkappointmentrequest() {}
}

class Appointment {}

class PetDetails {}
