import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(_userData!['name']),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(_userData!['email']),
                ),
                ListTile(
                  title: Text('Date of Birth'),
                  subtitle: Text(_userData!['dob']),
                ),
                ListTile(
                  title: Text('Gender'),
                  subtitle: Text(_userData!['gender']),
                ),
                ListTile(
                  title: Text('Roll Number'),
                  subtitle: Text(_userData!['roll_number']),
                ),
                ListTile(
                  title: Text('Department'),
                  subtitle: Text(_userData!['department']),
                ),
                ListTile(
                  title: Text('Semester'),
                  subtitle: Text(_userData!['semester']),
                ),
              ],
            ),
    );
  }
}
