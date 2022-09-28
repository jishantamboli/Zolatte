import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zolatte/home_page.dart';
import 'package:zolatte/main.dart';
import 'package:zolatte/menu.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // User? user;
  var signstyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  var loginstyle =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  var signupstyle = TextStyle(
      color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold);
  final _formkey = GlobalKey<FormState>();

  // moveToLogin(BuildContext context) async {
  //   if (_formkey.currentState!.validate()) {
  //     setState(() {});
  //     await Navigator.pushNamed(context, MyRoutes.HomeRoute);
  //   }
  // }

  String error = "";
  final User_email = new TextEditingController();
  final User_password = new TextEditingController();
  final confirmpassword = new TextEditingController();

  Future<String?> SingUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: User_email.text, password: User_password.text);
      await Future.delayed(Duration(seconds: 1));

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Emailfield = TextFormField(
      autofocus: false,
      controller: User_email,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        User_email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(hintText: "Enter Email ", labelText: "Email"),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return "Email can't be empty";
      //   } else if (value.length < 6) {
      //     return "Email should be atleast 6 characters";
      //   }
      //   return null;
      // },
    );
    final passwordfield = TextFormField(
      autofocus: false,
      controller: User_password,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        User_password.text = value!;
      },
      textInputAction: TextInputAction.next,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Enter Password",
        labelText: "Password",
      ),
      // validator: (passvalue) {
      //   if (passvalue == null || passvalue.isEmpty) {
      //     return "Password cannot be empty";
      //   } else if (passvalue.length < 6) {
      //     return "Password length should be atleast 6 characters";
      //   }
      //   return null;
      // },
    );
    // final confirmpasswordfield = TextFormField(
    //   autofocus: false,
    //   controller: confirmpassword,
    //   keyboardType: TextInputType.visiblePassword,
    //   onSaved: (value) {
    //     confirmpassword.text = value!;
    //   },
    //   // textInputAction: TextInputAction.next,
    //   obscureText: true,
    //   decoration: InputDecoration(
    //     hintText: " Enter Password ",
    //     labelText: "Confirm Password",
    //   ),
    //   validator: (confvalue) {
    //     if (confvalue == null || confvalue.isEmpty) {
    //       return " This field is Required";
    //     } else if (confvalue.length < 6) {
    //       return "Password length should be atleast 6";
    //     } else if (confvalue != User_password.text) {
    //       return "Password does not match";
    //     }
    //     return null;
    //   },
    // );
    return Material(
      color: Colors.white,
      child: Form(
        key: _formkey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              "SignUp",
              style: signstyle,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Column(
                children: [
                  Emailfield,
                  SizedBox(
                    height: 30,
                  ),
                  passwordfield,
                  SizedBox(
                    height: 20,
                  ),
                  Text(error),
                  SizedBox(
                    height: 30,
                  ),
                  // confirmpasswordfield,
                  // Text(error),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15.0),
                    child: InkWell(
                      onTap: () => SingUp(),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 4),
                        child: Container(
                            width: 120,
                            height: 40,
                            alignment: Alignment.center,
                            child: Text(
                              "Sign up",
                              style: loginstyle,
                            )),
                      ),
                    ),
                  )
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, MyRoutes.HomeRoute);
                  //     },
                  //     style: ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStateProperty.all(Colors.red),
                  //         shape: MaterialStateProperty.all(
                  //             RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(15.0))),
                  //         padding: MaterialStateProperty.all(
                  //             EdgeInsets.symmetric(
                  //                 horizontal: 35, vertical: 10))),
                  //     child: Text(
                  //       "Login",
                  //       style: loginstyle,
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
