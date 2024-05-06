import 'package:communehub/onboarding/useroradmin.dart';
import 'package:communehub/user/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _userName;
  late String _userEmail;

  @override
  void initState() {
    super.initState();
    _userName = ''; // Initialize to empty string
    _userEmail = ''; // Initialize to empty string
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['name'];
          _userEmail = userDoc['email'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Profile'),
          ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300], // Placeholder color
              ),
              child: Icon(
                Icons.person, // Placeholder icon
                size: 80,
                color: Colors.white, // Placeholder color
              ),
            ),
            SizedBox(height: 20),
            Text(
              _userName.isNotEmpty
                  ? _userName
                  : 'Loading...', // Display loading if name is empty
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _userEmail.isNotEmpty
                  ? _userEmail
                  : 'Loading...', // Display loading if email is empty
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle edit profile button tap
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: Icon(Icons.event_sharp),
              title: Text('Registered Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CheckRegisteredEventsAndCompetitionsPage()),
                );

                // Handle registered events tap
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('User Management'),
              onTap: () {
                // Handle user management tap
              },
            ),
            Divider(),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Information'),
              onTap: () {
                // Handle information tap
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut(); // Sign out the user
                // Navigate to the login page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginSelectionScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CheckRegisteredEventsAndCompetitionsPage extends StatefulWidget {
  @override
  _CheckRegisteredEventsAndCompetitionsPageState createState() =>
      _CheckRegisteredEventsAndCompetitionsPageState();
}

class _CheckRegisteredEventsAndCompetitionsPageState
    extends State<CheckRegisteredEventsAndCompetitionsPage> {
  late String _userName = '';
  bool _loading = true;
  bool _hasRegistered = false;
  List<Map<String, dynamic>> _registeredEvents = [];

  @override
  void initState() {
    super.initState();

    _fetchUserName();
    _checkRegistrations();
  }

  Future<void> _fetchUserName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['name'];
        });
      }
    }
  }

  Future<void> _checkRegistrations() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('registrations')
              .where('registrants', arrayContains: _userName)
              .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _registeredEvents = snapshot.docs.map((doc) => doc.data()).toList();
          _hasRegistered = true;
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error checking registrations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Events and Competitions'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _hasRegistered
              ? ListView.builder(
                  itemCount: _registeredEvents.length,
                  itemBuilder: (context, index) {
                    final event = _registeredEvents[index];
                    return ListTile(
                      title: Text(event['eventName']),
                      subtitle: Text(event['eventDate']),
                    );
                  },
                )
              : Center(
                  child: Text(
                      'You have not registered for any events or competitions.'),
                ),
    );
  }
}
