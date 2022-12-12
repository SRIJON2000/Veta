import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veta/constants.dart';

class Member {
  String email = "";
  String firstname = "";
  String lastname = "";
  String phoneNumber = "";
}

class Customer extends Member {
  Customer(
      String email, String firstname, String lastname, String phoneNumber) {
    this.email = email;
    this.firstname = firstname;
    this.lastname = lastname;
    this.phoneNumber = phoneNumber;
  }
  Future<void> getCustomerDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((results) {
      this.email = results.docs[0]['email'];
      this.firstname = results.docs[0]['firstname'];
      this.lastname = results.docs[0]['lastname'];
      this.phoneNumber = results.docs[0]['phoneNumber'];
    });
  }

  Future<void> Signup() async {
    await FirebaseFirestore.instance.collection('users').add({
      'email': this.email,
      'firstname': this.firstname,
      'lastname': this.lastname,
      'phoneNumber': this.phoneNumber,
    });
  }

  void bookappointment(Appointment a) {
    a.addAppointment();
  }

  void searchdoctor() {}
  void bookpetcare() {}
}

class Doctor extends Member {
  String isLoggedin = "";
  String licenseNumber = "";
  String speciality = "";
  Doctor(String email, String firstname, String lastname, String phoneNumber,
      String isLoggedin, String licenseNumber, String speciality) {
    this.email = email;
    this.firstname = firstname;
    this.lastname = lastname;
    this.phoneNumber = phoneNumber;
    this.isLoggedin = isLoggedin;
    this.licenseNumber = licenseNumber;
    this.speciality = speciality;
  }
  Future<void> getDoctorDetails() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((results) {
      this.email = results.docs[0]['email'];
      this.firstname = results.docs[0]['firstname'];
      this.lastname = results.docs[0]['lastname'];
      this.phoneNumber = results.docs[0]['phoneNumber'];
      this.isLoggedin = results.docs[0]['isLoggedin'];
    });
  }

  Future<void> Signup() async {
    await FirebaseFirestore.instance.collection('doctors').add({
      'email': this.email,
      'firstname': this.firstname,
      'lastname': this.lastname,
      'phoneNumber': this.phoneNumber,
      'licenseNumber': this.licenseNumber,
      'speciality': this.speciality,
      'isLoggedin': "Online",
    });
  }

  void approveappointment() {}
  void providetime() {}
  void checkappointmentrequest() {}
}

class Pet {
  String type = "";
  String breed = "";
  String height = "";
  String weight = "";
  String age = "";
  String gender = "";
  Pet(String type, String breed, String height, String weight, String age,
      String gender) {
    this.type = type;
    this.breed = breed;
    this.height = height;
    this.weight = weight;
    this.age = age;
    this.gender = gender;
  }
}

class Appointment {
  Pet p = Pet("", "", "", "", "", "");
  String date = "";
  String time = "";
  String prefer_date = "";
  String prefer_time = "";
  String doctorid = "";
  String doctorname = "";
  String useremail = "";
  String username = "";
  String emergency = "";
  String status = "";
  Appointment(
      Pet p,
      String date,
      String time,
      String prefer_date,
      String prefer_time,
      String doctorid,
      String doctorname,
      String useremail,
      String username,
      String emergency,
      String status) {
    this.p = p;
    this.date = date;
    this.time = time;
    this.prefer_date = prefer_date;
    this.prefer_time = prefer_time;
    this.doctorid = doctorid;
    this.doctorname = doctorname;
    this.useremail = useremail;
    this.username = username;
    this.emergency = emergency;
    this.status = status;
  }
  Future<void> addAppointment() async {
    await FirebaseFirestore.instance.collection('requests').add({
      'age': this.p.age,
      'breed': this.p.breed,
      'date': this.date,
      'doctorid': this.doctorid,
      'doctorname': this.doctorname,
      'emergency': this.emergency,
      'gender': this.p.gender,
      'height': this.p.height,
      'pet_type': this.p.type,
      'prefer_date': this.prefer_date,
      'prefer_time': this.prefer_time,
      'status': this.status,
      'time': this.time,
      'useremail': this.useremail,
      'username': this.username,
      'weight': this.p.weight,
    });
  }
}

Customer global_customer = Customer("", "", "", "");
Doctor global_doctor = Doctor("", "", "", "", "", "", "");
