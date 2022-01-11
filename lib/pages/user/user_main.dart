import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_emailpass/pages/login.dart';
import 'package:flutter_fb_auth_emailpass/pages/user/dashboard.dart';
import 'package:flutter_fb_auth_emailpass/pages/user/profile.dart';
import 'package:flutter_fb_auth_emailpass/pages/user/change_password.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class userMain extends StatefulWidget {
  @override
  _userMainState createState() => _userMainState();
}

class _userMainState extends State<userMain> {
  int _selectedIndex = 0;
  final storage = new FlutterSecureStorage();
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    ChangePassword(),
  ];

  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Welcome User"),
            ElevatedButton(
              onPressed: () async => {
                /////////////////////////////////////////
                await FirebaseAuth.instance.signOut(),
                await storage.delete(key:"uid"),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false)
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MyProfile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Change Password'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemtapped,
      ),
    );
  }
}
