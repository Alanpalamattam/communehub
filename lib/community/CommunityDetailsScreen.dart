// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_application_1/reusable_widget/reusable_widget.dart';

class CommunityDetailsScreen extends StatelessWidget {
  final String name;

  CommunityDetailsScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Center(
          child: _buildCommunityDetails(context),
        ),
      ),
    );
  }

  Widget _buildCommunityDetails(BuildContext context) {
    switch (name) {
      case 'GDSC':
        return _buildGDSCDetails(context);
      case 'IEEE':
        return _buildIEEEDetails(context);
      case 'TINKER HUB':
        return _buildTINKERHUBDetails(context);
      case 'UI PATH':
        return _buildUIPATHDetails(context);
      case 'Mulearn':
        return _buildCSIDetails(context);

      // case 'UIPATH':
      // return _buildUIPATHDetails(context);
      // Add cases for other communities as needed
      default:
        return Text(
          'Details for $name are not available.',
          style: TextStyle(
              fontSize: 24.0, color: const Color.fromARGB(255, 36, 29, 29)),
        );
    }
  }

  Widget _buildGDSCDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Austin Benny', 'imagePath': 'assets/leadericon.jpg'},
      {'name': 'Aman Sabu', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Liya George', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Alan Peter', 'imagePath': 'assets/membericon.jpg'}
      // Example list of core members
    ];
    final List<String> events = [
      'assets/gdsc1.jpg',
      'assets/gdsc2.jpg',
      'assets/gdsc3.jpg',
      'assets/gdsc4.jpg',
      'assets/gdsc5.jpg',
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 255, 255, 255),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 21, 57, 199).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/gdscheader.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 150, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 10), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '18M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Google Developer Student Clubs',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 11, 23, 85).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'GDSCs, backed by Google Developers, are student-led communities fostering tech education and collaboration. Through workshops and events, students explore Google technologies, gain hands-on experience, and connect with industry mentors, empowering them to thrive in the tech world.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'GDSC activities typically include workshops, seminars, hackathons, coding competitions, study jams, and networking events. Through these activities, students not only gain practical experience and technical knowledge but also develop critical soft skills such as teamwork, communication, and problem-solving.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'Previous Events',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none, // Remove decoration
                  ),
                ),
                SizedBox(height: 30),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: events.map((event) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Image.asset(
                              event,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      'Austin Benny- 9853382522',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIEEEDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Akash vijay', 'imagePath': 'assets/leadericon.jpg'},
      {'name': 'Seion shoji', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Kavya KA', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Amal A', 'imagePath': 'assets/membericon.jpg'}
      // Example list of core members
    ];
    final List<String> events = [
      'assets/ieee1.jpg',
      'assets/ieee2.jpg',
      'assets/ieee3.jpg',
      'assets/ieee4.jpg',
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 249, 249, 249),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 200, 226, 27).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/ieeehh.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 350, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '180M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'IEEE',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // Add some vertical spacing
          Container(
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 200, 226, 27).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'IEEE (Institute of Electrical and Electronics Engineers) is a professional association for electronic engineering and electrical engineering (and associated disciplines) with its corporate office in New York City and its operations center in Piscataway, New Jersey. It was formed in 1963 from the amalgamation of the American Institute of Electrical Engineers and the Institute of Radio Engineers.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'IEEE provides a wide range of services and resources to its members, including publications, conferences, standards development, and educational programs. It publishes numerous prestigious journals and magazines covering cutting-edge research and developments in fields such as electrical engineering, computer science, telecommunications, biomedical engineering, and more.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'Previous Events',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none, // Remove decoration
                  ),
                ),
                SizedBox(height: 30),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: events.map((event) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Image.asset(
                              event,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      'Akash vijay- 9866482522',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTINKERHUBDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Athul Sabu', 'imagePath': 'assets/leadericon.jpg'},
      {'name': 'Aravind Prakash', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Liya Elizabath', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Ayush G', 'imagePath': 'assets/membericon.jpg'}
      // Example list of core members
    ];
    final List<String> events = [
      'assets/tinker2.jpg',
      'assets/tinker1.jpg',
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 92, 209, 172),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 36, 17, 17).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/tinkerhead.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 150, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 10), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '10L+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'TINKER HUB',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 26, 114, 82).withOpacity(0.8),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'TinkerHub is a vibrant community where tech enthusiasts come together to innovate, collaborate, and learn. Join us to explore cutting-edge technologies, share knowledge, and work on impactful projects. Lets build a brighter future together! ',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'The community within TinkerHub often organizes events, workshops, hackathons, and discussions on various topics ranging from software development, hardware tinkering, design, entrepreneurship, and emerging technologies like artificial intelligence, blockchain, and internet of things (IoT). Members can also find resources, tutorials, and mentorship opportunities to further their skills and projects.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'Previous Events',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none, // Remove decoration
                  ),
                ),
                SizedBox(height: 30),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: events.map((event) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Image.asset(
                              event,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      'Athul Sabu - 9856482522',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCSIDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Thomas Jose', 'imagePath': 'assets/leadericon.jpg'},
      {'name': 'Seion shoji', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Merlin Jaison', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Ajay krishna', 'imagePath': 'assets/membericon.jpg'}
    ];

    final List<String> events = [
      'assets/mulearn1.jpg',
      'assets/mulearn2.jpg',
      'assets/mulearn3.jpg',
      'assets/mulearn4.jpg',
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 249, 249, 249),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 58, 162, 200).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/mulearnhead.png",
              width: 550,
              height: 150,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 58, 144, 211).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 93, 82, 82),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '10M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 7, 6, 6),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'GTECH MULEARN',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height:5),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 57, 133, 220).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Gtech MuLearn is a pioneering platform that seamlessly integrates technology with education, revolutionizing the way people learn and acquire new skills. Designed with versatility and accessibility in mind, MuLearn caters to a diverse range of learners, from students seeking academic enrichment to professionals looking to upskill in their careers.',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'One of the standout features of Gtech MuLearn is its adaptive learning system, which tailors educational content to the individual needs and learning styles of each user. Through advanced algorithms and machine learning, the platform analyzes user interactions and performance data to personalize the learning experience, ensuring maximum engagement and comprehension.',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Previous Events',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 5),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: events.map((event) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Image.asset(
                              event,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 4, 4),
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 2, 2, 2),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      'Thomas Jose - 9856482522',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1),
                Text(
                  'LEAD',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUIPATHDetails(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Albin Sony', 'imagePath': 'assets/leadericon.jpg'},
      {'name': 'Seion shoji', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Noora Fathima', 'imagePath': 'assets/membericon.jpg'},
      {'name': 'Amal A', 'imagePath': 'assets/membericon.jpg'}
    ];
    final List<String> events = [
      'assets/uipath1.jpg',
      'assets/uipath1.jpg',
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 249, 249, 249),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 230, 101, 101).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Image.asset(
              "assets/uiphead.png",
              width: screenWidth, // Make image responsive to screen width
              height: screenWidth * 0.4, // Adjust image height as needed
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '05M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'UI PATH',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 192, 106, 106).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'UI Path is a leading platform for Robotic Process Automation (RPA) that enables organizations to automate repetitive tasks, streamline business processes, and improve operational efficiency. With UI Path, users can build, deploy, and manage software robots that mimic human actions to interact with digital systems and applications. Whether its automating data entry, invoice processing, or customer service tasks, UI Path empowers businesses to achieve greater productivity, accuracy, and cost savings',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Previous Events',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 30),
                CarouselSlider(
                  options: CarouselOptions(
                    height: screenWidth * 0.6, // Make carousel responsive
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: events.map((event) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: screenWidth,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Image.asset(
                              event,
                              fit: BoxFit.cover,
                              width: screenWidth,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 5),
                Text(
                  'Contact us',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Albin Sony-9856482522',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  'LEAD',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
