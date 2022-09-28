import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

var database = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            "https://zolatte-83e62-default-rtdb.firebaseio.com")
    .ref();

var user = FirebaseAuth.instance.currentUser;