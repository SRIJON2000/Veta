// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/class.dart';
import 'package:veta/screens/user_appointments.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:veta/screens/select_doctor.dart';
import 'package:veta/screens/global.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController doctor = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController age = TextEditingController();

  final _formDateKey = GlobalKey<FormState>();
  final _formTimeKey = GlobalKey<FormState>();
  final _formPetKey = GlobalKey<FormState>();
  final _formDoctorKey = GlobalKey<FormState>();
  final _formEmergencyKey = GlobalKey<FormState>();
  final _formBreedKey = GlobalKey<FormState>();
  final _formHeightKey = GlobalKey<FormState>();
  final _formWeightKey = GlobalKey<FormState>();
  final _formAgeKey = GlobalKey<FormState>();
  final _formGenderKey = GlobalKey<FormState>();

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
  final List<String> gender = ['Male', 'Female'];

  String? selectedPet;
  String? selectedEmergency;
  String? selectedGender;

  String userid = "";
  String username = "";

  Future book() async {
    if (_formDateKey.currentState!.validate() &&
        _formTimeKey.currentState!.validate() &&
        _formPetKey.currentState!.validate() &&
        _formDoctorKey.currentState!.validate() &&
        _formEmergencyKey.currentState!.validate() &&
        _formHeightKey.currentState!.validate() &&
        _formWeightKey.currentState!.validate() &&
        _formAgeKey.currentState!.validate() &&
        _formGenderKey.currentState!.validate() &&
        _formBreedKey.currentState!.validate()) {
      Pet pet = Pet(selectedPet.toString(), breed.text, height.text,
          weight.text, age.text, selectedGender.toString());
      Appointment appointment = Appointment(
          pet,
          "${_datetime.day} / ${_datetime.month} / ${_datetime.year}",
          timeInput.text,
          "null",
          "null",
          doctorid,
          doctorname,
          global_customer.email.toString(),
          global_customer.firstname + " " + global_customer.lastname,
          selectedEmergency.toString(),
          "Pending");
      global_customer.bookappointment(appointment);
      // loadAppointmentRequest();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Container(
                  height: 200,
                  child: Column(children: [
                    const Text(
                      "Your Appointment Request Has Been Successfully Sent To The Doctor, Kindly check My Appointments For Further Update",
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.deepPurple, //background color of button
                          side: const BorderSide(
                              width: 3,
                              color:
                                  Colors.deepPurple), //border width and color
                          elevation: 6, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(
                              30) //content padding inside button
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserAppointment()),
                        );
                      },
                      child: const Text("Go to my appointments"),
                    ),
                  ])));
        },
      );
    }
  }

  Future loadAppointmentRequest() async {
    await FirebaseFirestore.instance.collection('requests').add({
      'age': age.text.trim(),
      'breed': breed.text.trim(),
      'date': "${_datetime.day} / ${_datetime.month} / ${_datetime.year}",
      'doctorid': doctorid.trim(),
      'doctorname': doctorname.trim(),
      'emergency': selectedEmergency,
      'gender': selectedGender,
      'height': height.text.trim(),
      'pet_type': selectedPet,
      'prefer_date': "null",
      'prefer_time': "null",
      'status': "Pending",
      'time': timeInput.text.trim(),
      'useremail': user!.email,
      'username': username.trim(),
      'weight': weight.text.trim(),
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Container(
                height: 200,
                child: Column(children: [
                  const Text(
                    "Your Appointment Request Has Been Successfully Sent To The Doctor, Kindly check My Appointments For Further Update",
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.deepPurple, //background color of button
                        side: const BorderSide(
                            width: 3,
                            color: Colors.deepPurple), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(
                            30) //content padding inside button
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserAppointment()),
                      );
                    },
                    child: const Text("Go to my appointments"),
                  ),
                ])));
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

  Future getusername() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((QuerySnapshot results) async {
      username =
          "${results.docs[0]["firstname"]} ${results.docs[0]["lastname"]}";
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
    getusername();
    doctorname = "";
    doctorid = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Appointment Booking"),
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
                  'Welcome',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Book Your Appointments with your details!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 25),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text("Appointment Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      )),
                ),
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formDateKey,
                    child: TextFormField(
                      readOnly: true, // Add this to not show the keyboard Input
                      controller: dateInput,
                      onTap: _showDatePicker,
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
                        hintText: 'Appointment Date',
                        prefixIcon: const Icon(Icons.calendar_month),
                        contentPadding: const EdgeInsets.all(12.0),
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
                const SizedBox(height: 5),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "This date is for your preference. Actual appointment date will be given by the doctor",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 9,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formTimeKey,
                    child: TextFormField(
                      readOnly: true,
                      controller: timeInput,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          //print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          //print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          //print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                          setState(() {
                            timeInput.text = formattedTime
                                .toString(); //set the value of text field.
                          });
                        } else {
                          //print("Time is not selected");
                        }
                      },
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
                        hintText: 'Appointment Time',
                        prefixIcon: const Icon(Icons.punch_clock),
                        contentPadding: const EdgeInsets.all(12.0),
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
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "This time is for your preference. Actual appointment time will be given by the doctor",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 9,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formEmergencyKey,
                    child: DropdownButtonFormField2(
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
                        contentPadding: const EdgeInsets.all(12.0),
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

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formDoctorKey,
                    child: TextFormField(
                      readOnly: true,
                      controller: doctor,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          // Create the SelectionScreen in the next step.
                          MaterialPageRoute(
                              builder: (context) => const SelectDoctor()),
                        );
                        setState(() {
                          doctor.text = doctorname;
                        });
                      },
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
                        hintText: 'Select Doctor',
                        contentPadding: const EdgeInsets.all(12.0),
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
                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text("Pet Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      )),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formPetKey,
                    child: DropdownButtonFormField2(
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
                        contentPadding: const EdgeInsets.all(12.0),
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

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formBreedKey,
                    child: TextFormField(
                      controller: breed,
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
                        hintText: 'Enter breed name',
                        contentPadding: const EdgeInsets.all(12.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (breed) {
                        if (breed == null || breed.isEmpty) {
                          return 'Please enter your breed name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formHeightKey,
                    child: TextFormField(
                      controller: height,
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
                        hintText: 'Enter Height',
                        contentPadding: const EdgeInsets.all(12.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (breed) {
                        if (breed == null || breed.isEmpty) {
                          return 'Please enter height';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formWeightKey,
                    child: TextFormField(
                      controller: weight,
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
                        hintText: 'Enter Weight',
                        contentPadding: const EdgeInsets.all(12.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (breed) {
                        if (breed == null || breed.isEmpty) {
                          return 'Please enter weight';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formAgeKey,
                    child: TextFormField(
                      //keyboardType: TextInputType.number,
                      controller: age,
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
                        hintText: 'Enter Age',
                        contentPadding: const EdgeInsets.all(12.0),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      //keyboardType: TextInputType.number,
                      validator: (breed) {
                        if (breed == null || breed.isEmpty) {
                          return 'Please enter age';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formGenderKey,
                    child: DropdownButtonFormField2(
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
                        contentPadding: const EdgeInsets.all(12.0),
                        hintText: 'Select Gender',
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
                      items: gender
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
                          selectedGender = value.toString();
                        });
                      },
                      onSaved: (value) {
                        selectedGender = value.toString();
                      },
                      validator: (pet) {
                        if (pet == null || pet.isEmpty) {
                          return 'Please select gender';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: book,
                    child: Ink(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
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
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
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
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
