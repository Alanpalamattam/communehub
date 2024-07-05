import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RankingTablePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking Table (Content)'),
        backgroundColor: Color(0xFFE7E0C9), // Background color of app bar
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Light background color for body
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('execom_scores')
              .orderBy('average_score', descending: true) // Order by average_score in descending order
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot>? documents = snapshot.data?.docs;

            if (documents == null || documents.isEmpty) {
              return Center(child: Text('No data available'));
            }

            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: DataTable(
                  columnSpacing: 20.0,
                  headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xFFB760D5)),
                  headingTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  dataTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                  columns: [
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Average Score')),
                  ],
                  rows: documents
                      .map((doc) => DataRow(cells: [
                            DataCell(Text(doc.id)), // Document ID is the email
                            DataCell(Text(doc['average_score'].toString())),
                          ]))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
