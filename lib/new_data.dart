import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:zolatte/global.dart';
import 'package:zolatte/home_page.dart';
import 'main.dart';

class NewData extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController name = TextEditingController();

  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('profile').child(user!.uid);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Add Data"),
        // backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'name',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            tile("Name", name ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                ref
                    .push()
                    .set(
                      title.text,
                    )
                    .asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              },
              child: Text(
                "save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tile(String name, TextEditingController data) => Container(
        decoration: BoxDecoration(border: Border.all()),
        child: TextField(
          controller: data,
          decoration: InputDecoration(
            hintText: name,
          ),
        ),
      );
}
