import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/screens/petcare_form.dart';
import 'package:veta/util/my_box.dart';
import 'package:veta/util/my_tile.dart';
import 'dart:async';

import 'package:veta/screens/book_appointment.dart';
import 'package:veta/screens/doctor_details.dart';
import 'package:veta/screens/data_getter.dart';
import 'package:veta/screens/petcare_form.dart';

class DoctorScaffold extends StatefulWidget {
  const DoctorScaffold({Key? key}) : super(key: key);

  @override
  State<DoctorScaffold> createState() => _DoctorScaffoldState();
}

class _DoctorScaffoldState extends State<DoctorScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultBackgroundColor,
        appBar: myAppBar,
        drawer: myDrawer,
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                color: Colors.deepPurple,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 152, 37, 37), //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.deepPurple), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: () {},
                    child: Text("Check Appointment Requests"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Expanded(
            //   child: Container(
            //     color: Colors.deepPurple,
            //     child: Center(
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             primary: Color.fromARGB(
            //                 255, 152, 37, 37), //background color of button
            //             side: BorderSide(
            //                 width: 3,
            //                 color: Colors.deepPurple), //border width and color
            //             elevation: 6, //elevation of button
            //             shape: RoundedRectangleBorder(
            //                 //to set border radius to button
            //                 borderRadius: BorderRadius.circular(30)),
            //             padding:
            //                 EdgeInsets.all(30) //content padding inside button
            //             ),
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => DoctorDetails()),
            //           );
            //         },
            //         child: Text("Search For Doctor"),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            // Expanded(
            //   child: Container(
            //     color: Colors.deepPurple,
            //     child: Center(
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             primary: Color.fromARGB(
            //                 255, 152, 37, 37), //background color of button
            //             side: BorderSide(
            //                 width: 3,
            //                 color: Colors.deepPurple), //border width and color
            //             elevation: 6, //elevation of button
            //             shape: RoundedRectangleBorder(
            //                 //to set border radius to button
            //                 borderRadius: BorderRadius.circular(30)),
            //             padding:
            //                 EdgeInsets.all(30) //content padding inside button
            //             ),
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => PetCareForm()),
            //           );
            //         },
            //         child: Text("Book Petcare Personnel"),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            // Expanded(
            //   child: Container(
            //     color: Colors.deepPurple,
            //     child: Center(
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             primary: Color.fromARGB(
            //                 255, 152, 37, 37), //background color of button
            //             side: BorderSide(
            //                 width: 3,
            //                 color: Colors.deepPurple), //border width and color
            //             elevation: 6, //elevation of button
            //             shape: RoundedRectangleBorder(
            //                 //to set border radius to button
            //                 borderRadius: BorderRadius.circular(30)),
            //             padding:
            //                 EdgeInsets.all(30) //content padding inside button
            //             ),
            //         onPressed: null,
            //         child: Text("Buy Food Supplement"),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 10),
          ],
        )));
  }
}
