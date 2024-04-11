import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy events data with event name, date, number of participants, and corresponding image path
    List<Map<String, dynamic>> events = [
      {
        "name": "Event 1",
        "date": "2024-05-15",
        "participants": 50,
        "imagePath": "assets/meny.png",
        "color": Colors.white,
      },
      {
        "name": "Event 2",
        "date": "2024-06-20",
        "participants": 70,
        "imagePath": "assets/meny.png",
        "color": Colors.white,
      },
      {
        "name": "Event 2",
        "date": "2024-06-20",
        "participants": 70,
        "imagePath": "assets/meny.png",
        "color": Colors.white,
      },
      {
        "name": "Event 3",
        "date": "2024-07-10",
        "participants": 40,
        "imagePath": "assets/meny.png",
        "color": Colors.white,
      },
      {
        "name": "Event 2",
        "date": "2024-06-20",
        "participants": 70,
        "imagePath": "assets/meny.png",
        "color": Colors.white,
      },
      // Add more events as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Execom button tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 133, 65, 164), // Change the background color here
                ),
                child: Text(
                  'Events',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Execom button tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 0, 0, 0), // Change the background color here
                ),
                child: Text(
                  'Execom',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle competition button tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 0, 0, 0), // Change the background color here
                ),
                child: Text(
                  'Competition',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Events',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: events[index]["color"],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 40, 35, 35)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 9,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        events[index]["imagePath"],
                        width: 100, // Adjust size as needed
                        height: 100, // Adjust size as needed
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            events[index]["name"],
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date: ${events[index]["date"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Participants: ${events[index]["participants"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 70,
            color: Colors.white, // Background color of the search bar
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(219, 213, 73, 240),
                    radius: 35,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
