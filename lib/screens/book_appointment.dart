import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/util/my_box.dart';
import 'package:veta/util/my_tile.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:veta/screens/select_doctor.dart';
import 'package:veta/screens/mobile_body.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:veta/screens/global.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  var session = SessionManager();

  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController doctor = TextEditingController();

  final _formDateKey = GlobalKey<FormState>();
  final _formTimeKey = GlobalKey<FormState>();
  final _formPetKey = GlobalKey<FormState>();
  final _formDoctorKey = GlobalKey<FormState>();
  final _formEmergencyKey = GlobalKey<FormState>();

  final List<String> pet = [
    'Dog',
    'Cat',
    'Horse',
    'Cow',
    'Buffelow',
    'Bird',
    'Goat'
  ];

  final List<String> emergency = ['Yes', 'No'];

  String? selectedPet;
  //String? selectedDoctor;
  String? selectedEmergency;

  String userid = "";

  Future getdoc() async {
    doctor.text = s;
  }

  Future book() async {
    if (_formDateKey.currentState!.validate() &&
        _formTimeKey.currentState!.validate() &&
        _formPetKey.currentState!.validate() &&
        _formDoctorKey.currentState!.validate() &&
        _formEmergencyKey.currentState!.validate()) {
      //getuserid();
      loadAppointmentRequest();
    }
  }

  Future loadAppointmentRequest() async {
    await FirebaseFirestore.instance.collection('requests').add({
      'date': "${_datetime.day} / ${_datetime.month} / ${_datetime.year}",
      'doctorid': doctor.text.trim(),
      'emergency': selectedEmergency,
      'pet_type': selectedPet,
      'prefer_date': "null",
      'prefer_time': "null",
      'status': "Not Approved",
      'time': timeInput.text.trim(),
      'userid': userid,
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text(
          "Your Appointment Request Has Been Sent To The Doctor, Kindly check My Appointments For Doctor's Reply",
          textAlign: TextAlign.center,
        ));
      },
    );
    //const MobileScaffold();
  }

  Future getuserid() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((QuerySnapshot results) async {
      userid = results.docs[0].id;
    });
  }

  DateTime _datetime = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _datetime = value!;
        dateInput.text = DateFormat('yyyy-MM-dd').format(_datetime);
      });
    });
  }

  @override
  void initState() {
    dateInput.text = "";
    timeInput.text = ""; //set the initial value of text field
    getuserid();
    super.initState();
    s = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Appointment Booking"),
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
                  'Welcome',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Book Your Appointments with your details!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formDateKey,
                    child: TextFormField(
                      controller: dateInput,
                      onTap: _showDatePicker,
                      //onTap: () async {
                      //   DateTime? pickedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(1950),
                      //       //DateTime.now() - not to allow to choose before today.
                      //       lastDate: DateTime(2100));

                      //   if (pickedDate != null) {
                      //     print(
                      //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      //     String formattedDate =
                      //         DateFormat('yyyy-MM-dd').format(pickedDate);
                      //     print(
                      //         formattedDate); //formatted date output using intl package =>  2021-03-16
                      //     setState(() {
                      //       dateInput.text =
                      //           formattedDate; //set output date to TextField value.
                      //     });
                      //   } else {}
                      // },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Appointment Date',
                        prefixIcon: Icon(Icons.calendar_month),
                        contentPadding: EdgeInsets.all(20.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (date) {
                        if (date == null || date.isEmpty) {
                          return 'Please enter date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formTimeKey,
                    child: TextFormField(
                      controller: timeInput,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                          setState(() {
                            timeInput.text =
                                formattedTime; //set the value of text field.
                          });
                        } else {
                          print("Time is not selected");
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Appointment Time',
                        prefixIcon: Icon(Icons.punch_clock),
                        contentPadding: EdgeInsets.all(20.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (time) {
                        if (time == null || time.isEmpty) {
                          return 'Please enter time';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formPetKey,
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.all(20.0),
                        hintText: 'Select Pet',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: pet
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Do Smoething here
                        setState(() {
                          selectedPet = value.toString();
                        });
                      },
                      onSaved: (value) {
                        selectedPet = value.toString();
                      },
                      validator: (pet) {
                        if (pet == null || pet.isEmpty) {
                          return 'Please select pet';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formDoctorKey,
                    child: TextFormField(
                      controller: doctor,
                      onTap: () async {
                        Navigator.push(
                          context,
                          // Create the SelectionScreen in the next step.
                          MaterialPageRoute(
                              builder: (context) => SelectDoctor()),
                        );
                        await getdoc();
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Doctor Name',
                        contentPadding: EdgeInsets.all(20.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (doctor) {
                        if (doctor == null || doctor.isEmpty) {
                          return 'Please select doctor';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formEmergencyKey,
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.all(20.0),
                        hintText: 'Emergency or not',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: emergency
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Do Smoething here
                        setState(() {
                          selectedEmergency = value.toString();
                        });
                      },
                      onSaved: (value) {
                        selectedEmergency = value.toString();
                      },
                      validator: (emergency) {
                        if (emergency == null || emergency.isEmpty) {
                          return 'Please Emergency or not';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Form(
                //     key: _formDoctorKey,
                //     child: DropdownButtonFormField2(
                //       decoration: InputDecoration(
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white),
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.deepPurple),
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         contentPadding: EdgeInsets.all(20.0),
                //         hintText: 'Select Doctor',
                //         fillColor: Colors.grey[200],
                //         filled: true,
                //       ),
                //       icon: const Icon(
                //         Icons.arrow_drop_down,
                //         color: Colors.black45,
                //       ),
                //       buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                //       dropdownDecoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       items: doctors
                //           .map((item) => DropdownMenuItem<String>(
                //                 value: item,
                //                 child: Text(
                //                   item,
                //                 ),
                //               ))
                //           .toList(),
                //       onChanged: (value) {
                //         // Do Smoething here
                //         setState(() {
                //           selectedDoctor = value.toString();
                //         });
                //       },
                //       onSaved: (value) {
                //         selectedDoctor = value.toString();
                //       },
                //     ),
                //   ),
                // ),

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
                          'Book Appointment',
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
