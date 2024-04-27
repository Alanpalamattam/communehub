import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communehub/events/eventscreen.dart';

import 'package:communehub/user/loginscreen.dart';
import 'package:communehub/user/userprofile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Event {
  final String name;
  final String timings;
  final String description;
  final String imageUrl;
  // New field for event image URL

  Event({
    required this.name,
    required this.timings,
    required this.description,
    required this.imageUrl,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = '';
  String _userEmail = '';
  List<Event> _events = [];
  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchEvents();
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
          _userEmail = userDoc['email'];
        });
      }
    }
  }

  Future<void> _fetchEvents() async {
    QuerySnapshot eventSnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    setState(() {
      _events = eventSnapshot.docs.map((doc) {
        return Event(
          name: doc['name'],
          timings: doc['date'],
          description: doc['description'],
          imageUrl: doc['image_url'],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mock list of events (replace with actual data)
    // List<Event> events = [
    //   Event(
    //     name: 'Event 1',
    //     timings: '10:00 AM - 12:00 PM',
    //     description: 'Description for Event 1',
    //     imageUrl: 'assets/event1.jpg',
    //   ),
    //   Event(
    //     name: 'Event 2',
    //     timings: '1:00 PM - 3:00 PM',
    //     description: 'Description for Event 2',
    //     imageUrl: 'assets/event1.jpg',
    //   ),
    //   Event(
    //     name: 'Event 3',
    //     timings: '4:00 PM - 6:00 PM',
    //     description: 'Description for Event 3',
    //     imageUrl: 'assets/event1.jpg',
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300, // Light font weight
                    ),
                  ),
                  Text(
                    _userName,
                    style: TextStyle(
                      fontSize: 24, // Increased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(), // Add Spacer to push the profile picture to the right

            SizedBox(width: 16),
          ],
        ),
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              height: 4), // Added space between search bar and image slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17), // Circular border radius
              child: SizedBox(
                height: 190,
                child: ImageSlider(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventsPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF1A1A1A)),
                ),
                child: Text(
                  'Events',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExecomcallPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF1A1A1A)),
                ),
                child: Text(
                  'Execomcall',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompetitionsPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF1A1A1A)),
                ),
                child: Text(
                  'Competitions',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trending',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add functionality for "See All"
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 160,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            _events[index].imageUrl, // Use network image
                            fit:
                                BoxFit.cover, // Ensure the image covers the box
                            height: 130, // Adjust the height of the image
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _events[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Date: ${_events[index].timings}', // Correct field name
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Description: ${_events[index].description}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Add functionality for home button
              },
            ),
            IconButton(
              icon: Icon(Icons.event),
              onPressed: () {
                Navigator.pushNamed(context, '/communityhome');
                // Add functionality for event button
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Add functionality for profile button
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Add functionality for settings button
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 65, 129, 166),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            _userEmail,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Navigate to UserInputPage when floating action button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add functionality for drawer item 2
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add functionality for drawer item 2
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add functionality for drawer item 2
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add functionality for drawer item 2
              },
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false));
                final user = FirebaseAuth.instance.currentUser;
                print(user!.email);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> imagePaths = [
    "assets/slider.jpg",
    "assets/slider.jpg",
    "assets/slider.jpg"
  ];
  int _currentIndex = 0;

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % imagePaths.length;
    });
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imagePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: imagePaths.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.asset(
              imagePaths[index],
              fit: BoxFit.cover,
            );
          },
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imagePaths.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              );
            }),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: _previousImage,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: _nextImage,
          ),
        ),
      ],
    );
  }
}

class ExecomcallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Execomcall'),
      ),
      body: Center(
        child: Text('Execomcall Page'),
      ),
    );
  }
}

class CompetitionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Competitions'),
      ),
      body: Center(
        child: Text('Competitions Page'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
