import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/util/my_box.dart';
import 'package:veta/util/my_tile.dart';
import 'dart:async';

import 'package:veta/screens/book_appointment.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
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
                color: Color.fromARGB(255, 185, 90, 90),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 152, 37, 37), //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Color.fromARGB(
                                255, 88, 105, 163)), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookAppointment()),
                      );
                    },
                    child: Text("Book An Appointment"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 189, 187, 187),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.brown), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: null,
                    child: Text("Search For Doctor"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 189, 187, 187),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.brown), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: null,
                    child: Text("Book Petcare Personnel"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 189, 187, 187),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.brown), //border width and color
                        elevation: 6, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(30) //content padding inside button
                        ),
                    onPressed: null,
                    child: Text("Buy Food Supplement"),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
