// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:intl/intl.dart';

class AppointmentRequest extends StatefulWidget {
  AppointmentRequest({super.key});

  @override
  State<AppointmentRequest> createState() => _AppointmentRequestState();
}

class _AppointmentRequestState extends State<AppointmentRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Appointment Requests'),
        centerTitle: false,
      ),
      backgroundColor: defaultBackgroundColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('requests')
              .where('doctorid', isEqualTo: user!.email)
              .where('status', isEqualTo: "Pending")
              //.orderBy('date', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((snap) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 62, 20, 211),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Date requested: " + snap["date"].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Time requested: " + snap['time'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
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
                                                  SizedBox(height: 10),
                                                  Text("Height: " +
                                                      snap['height']
                                                          .toString()),
                                                  SizedBox(height: 10),
                                                  Text("Weight: " +
                                                      snap['weight']
                                                          .toString()),
                                                  SizedBox(height: 10),
                                                  Text("Age: " +
                                                      snap['age'].toString()),
                                                  SizedBox(height: 10),
                                                  Text("Gender: " +
                                                      snap['gender']
                                                          .toString()),
                                                  SizedBox(height: 10),
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context,
                                                            true), // passing true
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              )));
                                    },
                                  );
                                },
                                child: Center(
                                  child: Text('Pet Details',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white)),
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(
                                    30) //content padding inside button
                                ),
                            onPressed: () {
                              TextEditingController dateInput =
                                  TextEditingController();
                              TextEditingController timeInput =
                                  TextEditingController();
                              final _formDateKey = GlobalKey<FormState>();
                              DateTime _datetime = DateTime.now();
                              final _formTimeKey = GlobalKey<FormState>();
                              void _showDatePicker() {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                ).then((value) {
                                  setState(() {
                                    _datetime = value!;
                                    dateInput.text = DateFormat('yyyy-MM-dd')
                                        .format(_datetime);
                                  });
                                });
                              }

                              Future change() async {
                                await FirebaseFirestore.instance
                                    .collection('requests')
                                    .doc(snap.id)
                                    .update({
                                  "prefer_date":
                                      "${_datetime.day} / ${_datetime.month} / ${_datetime.year}",
                                  "prefer_time": timeInput.text.trim(),
                                  "status": "Upcoming",
                                });
                              }

                              Future approve() async {
                                if (_formDateKey.currentState!.validate() &&
                                    _formTimeKey.currentState!.validate()) {
                                  change();
                                }
                              }

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      content: Container(
                                          height: 250,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child: Text("Appointment Date",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.deepPurple,
                                                    )),
                                              ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child: Form(
                                                  key: _formDateKey,
                                                  child: TextFormField(
                                                    controller: dateInput,
                                                    onTap: _showDatePicker,
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .deepPurple),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      hintText:
                                                          'Appointment Date',
                                                      prefixIcon: Icon(
                                                          Icons.calendar_month),
                                                      contentPadding:
                                                          EdgeInsets.all(20.0),
                                                      fillColor:
                                                          Colors.grey[200],
                                                      filled: true,
                                                    ),
                                                    validator: (date) {
                                                      if (date == null ||
                                                          date.isEmpty) {
                                                        return 'Please enter date';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child: Text("Appointment Time",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.deepPurple,
                                                    )),
                                              ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child: Form(
                                                  key: _formTimeKey,
                                                  child: TextFormField(
                                                    controller: timeInput,
                                                    onTap: () async {
                                                      TimeOfDay? pickedTime =
                                                          await showTimePicker(
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                        context: context,
                                                      );

                                                      if (pickedTime != null) {
                                                        print(pickedTime.format(
                                                            context)); //output 10:51 PM
                                                        DateTime parsedTime =
                                                            DateFormat.jm()
                                                                .parse(pickedTime
                                                                    .format(
                                                                        context)
                                                                    .toString());
                                                        //converting to DateTime so that we can further format on different pattern.
                                                        print(
                                                            parsedTime); //output 1970-01-01 22:53:00.000
                                                        String formattedTime =
                                                            DateFormat(
                                                                    'HH:mm:ss')
                                                                .format(
                                                                    parsedTime);
                                                        print(
                                                            formattedTime); //output 14:59:00
                                                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                        setState(() {
                                                          timeInput.text =
                                                              formattedTime; //set the value of text field.
                                                        });
                                                      } else {
                                                        print(
                                                            "Time is not selected");
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .deepPurple),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      hintText:
                                                          'Appointment Time',
                                                      prefixIcon: Icon(
                                                          Icons.punch_clock),
                                                      contentPadding:
                                                          EdgeInsets.all(20.0),
                                                      fillColor:
                                                          Colors.grey[200],
                                                      filled: true,
                                                    ),
                                                    validator: (time) {
                                                      if (time == null ||
                                                          time.isEmpty) {
                                                        return 'Please enter time';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .deepPurple, //background color of button
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Colors
                                                                  .deepPurple), //border width and color
                                                          elevation:
                                                              6, //elevation of button
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  //to set border radius to button
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30)),
                                                          padding: EdgeInsets.all(
                                                              30) //content padding inside button
                                                          ),
                                                  onPressed: () {
                                                    approve();
                                                    Navigator.pop(
                                                        context, true);
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            content: Container(
                                                          height: 100,
                                                          child: Text(
                                                            "You Have Successfully Approved The Request",
                                                          ),
                                                        ));
                                                      },
                                                    ); // passing true
                                                  },
                                                  child: Text("Approve"),
                                                ),
                                              ),
                                            ],
                                          )));
                                },
                              );
                            },
                            child: Text("Provide Date Time"),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ElevatedButton(
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
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: EdgeInsets.all(
                                          30) //content padding inside button
                                      ),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('requests')
                                        .doc(snap.id)
                                        .update({
                                      "prefer_date": snap["date"],
                                      "prefer_time": snap["time"],
                                      "status": "Upcoming",
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            content: Container(
                                          height: 100,
                                          child: Text(
                                            "You Have Successfully Approved The Request",
                                          ),
                                        ));
                                      },
                                    );
                                  },
                                  child: Text("Approve"),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
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
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: EdgeInsets.all(
                                          30) //content padding inside button
                                      ),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('requests')
                                        .doc(snap.id)
                                        .update({
                                      "status": "Denied",
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            content: Container(
                                          height: 100,
                                          child: Text(
                                            "You Have Successfully Denied The Request",
                                          ),
                                        ));
                                      },
                                    );
                                  },
                                  child: Text("Deny"),
                                ),
                              ],
                            )),
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
