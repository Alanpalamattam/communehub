import 'package:communehub/events/admininput.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E0C9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E0C9),
        title: Text('Event Details'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No events found'));
          }

          // Events found, display them
          final events = snapshot.data!.docs;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final event = events[index].data();
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20), // Add padding around the card
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsPageadmin(
                          event: event,
                          eventDocId: events[index].id,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Set circular border radius
                    ),
                    elevation: 5, // Add elevation for a card effect
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 20), // Add padding inside the card
                      leading: Container(
                        // height: 300,
                        width: 80,
                        // margin: EdgeInsets.only(right: 16),
                        // borderRadius: BorderRadius.circular(
                        //     5.0), // Set circular border radius
                        child: Image.network(
                          event['imageUrl'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Text(
                        '${event['nameOfEvent']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27, // Adjust the font size as needed
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${event['date']}',
                            style: TextStyle(
                              fontSize: 18, // Adjust the font size as needed
                            ),
                          ),
                          Text(
                            '${event['nameOfCommunity']}',
                            style: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                          Text(
                            '${event['modeOfConduct']}',
                            style: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Delete the event from Firebase and navigate back to the EventDetailsPage
                          FirebaseFirestore.instance
                              .collection('events')
                              .doc(events[index].id)
                              .delete()
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Event deleted'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error deleting event'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to UserInputPage when floating action button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserInputPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red, // Set background color to red
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class EventDetailsPageadmin extends StatelessWidget {
  final Map<String, dynamic> event;
  final String eventDocId;

  EventDetailsPageadmin({required this.event, required this.eventDocId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event["nameOfEvent"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF7E53D6),
      ),
      body: Material(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFECECEC),
            borderRadius: BorderRadius.circular(20),
          ),
          constraints: BoxConstraints.expand(height: double.infinity),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        event["imageUrl"],
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Event Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Name: ${event["name"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Date: ${event["date"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Participants: ${event["participants"]}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'Mode of Conduct: ${event["conductMode"]}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Done'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.info),
                      label: Text('Event Details'),
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date and Time: ${event["date"]}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${event["description"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Participants: ${event["participants"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Mode of Conduct: ${event["conductMode"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // Delete the event from Firebase and navigate back to the EventDetailsPage
          FirebaseFirestore.instance
              .collection('events')
              .doc(eventDocId)
              .delete()
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Event deleted'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error deleting event'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        },
        child: Container(
          color: Color(0xFF7E53D6),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete),
              SizedBox(width: 10),
              Text(
                'Delete Event',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
