import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Import intl package

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  List<Map<String, dynamic>> _registeredEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchRegisteredEvents();
  }

  Future<void> _fetchRegisteredEvents() async {
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

    setState(() {
      _registeredEvents = registeredEvents.map((event) {
        return {
          'eventName': event['eventName'],
          'eventDate': event['eventDate'],
          'eventTime': event['eventTime'],
          'eventType': event['eventType'], // Add eventType
        };
      }).toList();
    });
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _registeredEvents.where((event) {
      final eventDate =
          DateFormat('yyyy-MM-dd H:mm a').parse(event['eventDate']);
      return eventDate.year == day.year &&
          eventDate.month == day.month &&
          eventDate.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Calendar'),
        // backgroundColor: Color(0xFF7E53D6),
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
      ),
      body: Column(
        children: [
          Container(
            height:
                400, // Increase this value to increase the height of the calendar
            child: TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF7E53D6),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Color(0xFF7E53D6),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: Color(0xFF7E53D6),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: const Color.fromARGB(255, 20, 20, 20),
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: const Color.fromARGB(255, 42, 42, 42),
                ),
              ),
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF7E53D6),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                todayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: Container(
              // decoration: BoxDecoration(
              //   color: Color.fromARGB(255, 220, 219, 219),
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(12),
              //     topRight: Radius.circular(12),
              //   ),
              // ),
              child: Column(
                children: [
                  if (_getEventsForDay(_selectedDate).isEmpty)
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: 0),
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'No events registered on this day',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 18,
                        ),
                      ),
                    ),
                  Expanded(
                    child: _getEventsForDay(_selectedDate).isEmpty
                        ? SizedBox() // Display nothing if no events
                        : ListView.builder(
                            itemCount: _getEventsForDay(_selectedDate).length,
                            itemBuilder: (context, index) {
                              final event =
                                  _getEventsForDay(_selectedDate)[index];
                              final eventName = event['eventName'] ?? 'No Name';
                              final eventDate = event['eventDate'] ?? 'No Date';
                              final eventType = event['eventType'] ?? '';

                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                                child: InkWell(
                                  onTap: () {
                                    // Navigate to event detail page based on eventType
                                    if (eventType == 'competition') {
                                      // Navigate to competition details page
                                    } else {
                                      // Navigate to event details page
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7E53D6),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        eventName,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        eventDate,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
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
