
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zolatte/home_page.dart';

import '../auth/auth_service.dart';
import 'otp_signup.dart';

class LoginwithOTP extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  var sign1Style = const TextStyle(
      color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold);
  int code = 0;

  void login(BuildContext context) async {
    var loginResponse = await AuthService().signInPhone(_phoneController.text);
    if (loginResponse == 'Success') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  Home()));
    } else {
       Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  Home()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loginResponse)));
      
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
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 56,
            ),
            IntlPhoneField(
              controller: _phoneController,
              decoration: const InputDecoration(
                //decoration for Input Field
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              //default contry code, NP for India
              onChanged: (phone) {
                settate() {
                  var code = phone.countryCode.toString();
                }
              },
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(8)),
            //           borderSide: BorderSide(color: Colors.grey.shade200)),
            //       focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(8)),
            //           borderSide: BorderSide(color: Colors.grey.shade300)),
            //       filled: true,
            //       fillColor: Colors.grey[100],
            //       hintText: "XXXXXXXX"),
            //   controller: _phoneController,
            // ),
            SizedBox(
              height: 36,
            ),
            Text("Enter PIN "),
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
                  hintText: "PIN"),
              controller: _pinController,
            ),
            SizedBox(
              height: 36,
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                child: Text("Login"),
                textColor: Colors.white,
                padding: EdgeInsets.all(16),
                onPressed: () {
                  login(context);
                  print(_phoneController.text);
                },
                color: Colors.blue,
              ),
            ),
            Center(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Or"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OTPSignup()));
                  },
                  child: Text(
                    "SignUp",
                    style: sign1Style,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
