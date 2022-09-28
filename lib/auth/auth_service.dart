import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return "verification_email_sent";
      }
      return "success";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  // Future<String> otpSignup(String mobile)async{
  //   try {
  //     await auth.verifyPhoneNumber(
  //       phoneNumber: mobile,
  //       verificationCompleted: (PhoneAuthCredential credential) {
  //         print("verification completed");
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         if (e.code == 'invalid-phone-number') {
  //           ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('The provided phone number is not valid.')));
  //         }
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         // Update the UI - wait for the user to enter the SMS code
  //         String smsCode = 'xxxxxx';
  //         print('Verification id is ' + verificationId);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => verifyOTP(
  //                       verId: verificationId,
  //                     )));
  //         print("Moving to next page to verifying");
  //       },
  //       timeout: const Duration(seconds: 60),
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         // Auto-resolution timed out...
  //       },
  //     );

  //   } catch (e) {
  //   }

  // }

  Future<String> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
      }
      return "verification_email_sent";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  Future<String> signUpPhone(String verId, String smsCode) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  Future<String> signInPhone(String phone) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      
      // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
      ConfirmationResult confirmationResult =
          await auth.signInWithPhoneNumber(phone);
      UserCredential userCredential =
          await confirmationResult.confirm('123456');
      // await auth.signInWithCredential(credential);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  Future<String> passwordReset(String email) async {
    try {
      final _auth = FirebaseAuth.instance;
      await _auth.sendPasswordResetEmail(email: email);
      return "success";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  Future<String> changePass(String currentPass, String newPass) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User? currentUser = firebaseAuth.currentUser;
      await currentUser!.updatePassword(newPass);
      return "success";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  /// gets the current users email from firebase
  String? getCurrentUserEmail() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }

  /// Logs the current user out of firebase
  Future<String> logOut() async {
    await FirebaseAuth.instance.signOut();
    return "success";
  }

  Stream<User?> getCurrentUserLoginStatus() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
