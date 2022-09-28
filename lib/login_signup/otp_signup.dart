import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zolatte/login_signup/verify_phone.dart';

class OTPSignup extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPINController = TextEditingController();
  String _verificationId = '';
  bool _showverify = false;

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print('Mobile no is: ' + mobile);
    print('phonecontroller  is: ' + _phoneController.text);

    if (_phoneController.text.isEmpty ) {
      ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Phone no. is required')));
    } else if(_confirmPINController.text.isEmpty || _confirmPINController.text.isEmpty){
      ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('PIN is required')));
    }
    else {
      await auth.verifyPhoneNumber(
        phoneNumber: mobile,
        verificationCompleted: (PhoneAuthCredential credential) {
          print("verification completed");
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('The provided phone number is not valid.')));
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = 'xxxxxx';
          print('Verification id is ' + verificationId);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => verifyOTP(
                        verId: verificationId,
                      )));
          print("Moving to next page to verifying");
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    }
  }

  //Place A
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
                "Signup",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Container(
                child: IntlPhoneField(
              controller: _phoneController,
              decoration: InputDecoration(
                //decoration for Input Field
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              //default contry code, NP for India
              onChanged: (phone) {
                //when phone number country code is changed
                // print(phone.completeNumber); //get complete number
                // print(phone.countryCode); // get country code only
                // print(phone.number); // only phone number
              },
            )),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 6,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "PIN"),
              controller: _pinController,
            ),
            SizedBox(
              height: 55,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 6,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "Confirm PIN"),
              controller: _confirmPINController,
            ),
            // OtpTextField(
            //   fillColor: Colors.amberAccent,
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
            //     // showDialog(
            //     //     context: context,
            //     //     builder: (context){
            //     //     return AlertDialog(
            //     //         title: Text("Verification Code"),
            //     //         content: Text('Code entered is $verificationCode'),
            //     //     );
            //     //     }
            //     // );
            //   }, // end onSubmit
            // ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 36,
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                child: Text("Signup"),
                textColor: Colors.white,
                padding: EdgeInsets.all(16),
                onPressed: () {
                  if (_pinController.text != _confirmPINController.text ||
                      _pinController.text == _confirmPINController.text) {
                    final mobile = '+91 ' + _phoneController.text.trim();
                    registerUser(mobile, context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('PIN should be same')));
                  }

                  //code for sign in
                  // Place B
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
