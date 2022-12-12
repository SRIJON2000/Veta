import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';
import 'package:veta/widget/profile_widget.dart';
import 'package:veta/screens/data_getter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String doctorname = "";
  String username = "";
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

  @override
  void initState() {
    type = "";
    getUser_type();
    if (type == "Doctor") {
      getDoctor_info(email.toString());
    } else {
      getUser_info(email.toString());
    }
    setState(() {
      doctorname = "Dr. $doctor_firstname $doctor_lastname";
      username = "$user_firstname $user_lastname";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.grey[900], //background color of app bar
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath:
                'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F7%2F7e%2FCircle-icons-profile.svg%2F2048px-Circle-icons-profile.svg.png&imgrefurl=https%3A%2F%2Fen.m.wikipedia.org%2Fwiki%2FFile%3ACircle-icons-profile.svg&tbnid=J4bk_892RvNL_M&vet=12ahUKEwiG15Kd_vP7AhWviNgFHb8_CGkQMygEegUIARDmAQ..i&docid=TKW6teBKD3wYJM&w=2048&h=2048&q=profile&ved=2ahUKEwiG15Kd_vP7AhWviNgFHb8_CGkQMygEegUIARDmAQ',
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          if (type == "Doctor") ...[
            buildName(doctorname, doctor_phoneNumber, doctor_email)
          ] else ...[
            buildName(username, user_phoneNumber, user_email)
          ],
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout("Hello"),
        ],
      ),
    );
  }

  Widget buildName(name, phonenumber, email) => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            phonenumber,
            style: TextStyle(color: Colors.deepPurple),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.deepPurple),
          )
        ],
      );

  Widget buildAbout(about) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget NumbersWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '4.8', 'Rating'),
          buildDivider(),
          buildButton(context, '35', 'Appointments'),
          buildDivider(),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
