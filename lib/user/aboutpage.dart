import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'About',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 245, 244, 246),
            ),
          ),
        ),
        backgroundColor: Color(0xFF7E53D6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About CommuneHub',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7E53D6),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'CommuneHub is your go-to app for staying updated with community events, '
                'competitions, and meetings. Whether you are looking for the latest '
                'events or want to participate in exciting competitions, CommuneHub '
                'has got you covered. Our app aims to bring the community together, '
                'offering a centralized platform for all your event needs. Join us '
                'in fostering a connected and active community.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16),
              Divider(color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Key Features:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7E53D6),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- Browse and participate in community events\n'
                '- Stay updated with the latest competitions\n'
                '- Easy access to Execom calls and meetings\n'
                '- Personalized notifications\n'
                '- Seamless integration with your calendar',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16),
              Divider(color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Version: 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7E53D6),
                ),
              ),
              SizedBox(height: 24),
              Divider(color: Colors.grey),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFB760D5)),
                  SizedBox(width: 8),
                  Text(
                    'Thank you for using CommuneHub!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB760D5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
