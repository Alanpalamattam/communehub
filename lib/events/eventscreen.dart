import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class Event {
  final String name;
  final String timings;
  final String description;
  final String imageUrl;

  Event({
    required this.name,
    required this.timings,
    required this.description,
    required this.imageUrl,
  });
}

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late List<Event> _events;
  bool _isFetchingEvents = false;
  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    setState(() {
      _isFetchingEvents = true;
    });

    try {
      _subscription = FirebaseFirestore.instance
          .collection('events')
          .snapshots()
          .listen((eventSnapshot) {
        _events = eventSnapshot.docs.map((doc) {
          return Event(
            name: doc['name'],
            timings: doc['date'],
            description: doc['description'],
            imageUrl: doc['image_url'],
          );
        }).toList();
        setState(() {
          _isFetchingEvents = false;
        });
      });
    } catch (error) {
      print('Error fetching events: $error');
      // Show user-friendly error message
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: _isFetchingEvents
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                      Image.network(
                        event.imageUrl,
                        width: 100, // Adjust size as needed
                        height: 100, // Adjust size as needed
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date: ${event.timings}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${event.description}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          // Text(
                          //   'Participants: ${events[index]["participants"]}',
                          //   style: TextStyle(fontSize: 16),
                          // ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
