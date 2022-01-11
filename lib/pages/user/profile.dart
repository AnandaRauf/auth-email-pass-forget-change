import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print("Verification Email has Been Sent");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Verification Email has Been Sent",
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          Text(
            "User Id: $uid",
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                "email: $email",
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          user!.emailVerified
              ? Text('Verified')
              : TextButton(
                  onPressed: () => {verifyEmail()},
                  child: Text("Verify Email"),
                ),
          Text(
            "Created: $creationTime",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
