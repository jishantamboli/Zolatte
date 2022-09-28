import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zolatte/home_page.dart';

import '../auth/auth_service.dart';

class verifyOTP extends StatefulWidget {
  final String? verId;

  const verifyOTP({Key? key, this.verId});

  @override
  State<verifyOTP> createState() => _verifyOTPState();
}

var pin = '';
var confirmPin = '';

class _verifyOTPState extends State<verifyOTP> {
  final _phoneController = TextEditingController();

  verify() async {
      var verificationResponse =
          AuthService().signUpPhone(widget.verId ?? '', _phoneController.text);
      print("Phone verification");
      if (verificationResponse == "Success") {
        print("Logged IN");
       Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
      } else {
         ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(verificationResponse.toString())));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(22),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.only(top: 52),
              child: Text(
                "OTP Screen",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 56,
            ),
            Text("Enter OTP"),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "OTP"),
              controller: _phoneController,
            ),
            // OtpTextField(
            //   margin: EdgeInsets.all(14),
            //   numberOfFields: 6,
            //   borderColor: Color(0xFF512DA8),
            //   obscureText: true,
            //   //set to true to show as box or false to show as dash
            //   showFieldAsBox: false,
            //   //runs when a code is typed in
            //   onCodeChanged: (String code) {
            //     //handle validation or checks here
            //   },
            //   //runs when every textfield is filled
            //   onSubmit: (String verificationCode) {
            //     confirmPin = verificationCode;
            //     print(verificationCode);
            //   }, // end onSubmit
            // ),
            SizedBox(
              height: 36,
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                child: Text("Verify"),
                textColor: Colors.white,
                padding: EdgeInsets.all(16),
                onPressed: () {
                  verify();
                },
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
