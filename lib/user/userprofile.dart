import 'package:communehub/competitions/competitionscreen.dart';
import 'package:communehub/events/eventscreen.dart';
import 'package:communehub/onboarding/useroradmin.dart';
import 'package:communehub/user/aboutpage.dart';
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
                      builder: (context) => RegisteredEventsPage()),
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
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
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

class RegisteredEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Events'),
        backgroundColor: Color(0xFF7E53D6),
      ),
      body: FutureBuilder(
        future: _fetchRegisteredEvents(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No registered events'));
          } else {
            final registeredEvents = snapshot.data!;
            return ListView.builder(
              itemCount: registeredEvents.length,
              itemBuilder: (context, index) {
                final event = registeredEvents[index];
                final eventName = event['eventName'] ?? 'No Name';
                final eventDate = event['eventDate'] ?? 'No Date';
                final eventTime = event['eventTime'] ?? 'No Time';
                final eventType = event['eventType'] ?? ''; // Add eventType

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      // Check eventType to determine navigation
                      if (eventType == 'competition') {
                        // Navigate to competition details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompdisplayPage(),
                          ),
                        );
                      } else {
                        // Navigate to event details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventsPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          eventName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(eventDate),
                            // Text(eventTime),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchRegisteredEvents() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User not logged in');
    }
    final userEmail = currentUser.email;

    final snapshot =
        await FirebaseFirestore.instance.collection('registrations').get();
    final registeredEvents = snapshot.docs
        .where((doc) => (doc.data()['registrants'] as List)
            .any((registrant) => registrant['userEmail'] == userEmail))
        .map((doc) => doc.data())
        .toList();

    return registeredEvents.map((event) {
      return {
        'eventName': event['eventName'],
        'eventDate': event['eventDate'],
        'eventTime': event['eventTime'],
        'eventType': event['eventType'], // Add eventType
      };
    }).toList();
  }
}
