// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/mobile_body.dart';
import 'package:veta/screens/doctor_dash.dart';

// Getting users Table Data

late String user_firstname = '', user_phoneNumber = '', user_lastname = '';

Future getUser_info() async {
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: user!.email)
      .get()
      .then((QuerySnapshot results) {
    user_firstname = results.docs[0]['firstname'];
    user_phoneNumber = results.docs[0]['phoneNumber'];
    user_lastname = results.docs[0].id;
  });
}

Future getDoctor_info() async {
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('email', isEqualTo: user!.email)
      .get()
      .then((QuerySnapshot results) {
    user_firstname = results.docs[0]['firstname'];
    //user_phoneNumber = results.docs[0]['phoneNumber'];
    user_lastname = results.docs[0]['lastname'];
  });
}

// Getting user type

late String type = '';
Future getUser_type() async {
  await FirebaseFirestore.instance
      .collection('userType')
      .where('email', isEqualTo: user!.email)
      .get()
      .then((results) {
    type = results.docs[0]['type'];
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
