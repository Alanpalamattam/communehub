import 'package:communehub/execom_call/execom_admin2.dart';
import 'package:flutter/material.dart';

class ExecomDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Execom Details'),
        backgroundColor: Color(0xFFE7E0C9), // Background color of app bar
      ),
      body: Container(
        color: Color(0xFFE7E0C9), // Background color of body
        child: Center(
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(16.0, 0.0), // Move the container 20.0 units to the right
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 7.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: 350.0,
                      height: 170.0,
                      child: Image.asset(
                        "assets/IEEE.png", // Replace with your image path
                        fit: BoxFit.cover, // Stretch image to fill container
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 21.0,right: 20.0), // Adjust padding as needed
                  child: Opacity(
                    opacity: 1.0,
                    child: Text(
                      "     IEEE Call for execom",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 70), // Adjust padding as needed
                  child: Opacity(
                    opacity: 1.0,
                    child: Text(
                      "         Deadline : 5 April , 2024",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100.0, // Adjust button position from bottom
                left: 40.0, // Adjust button position from left (optional)
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PositionSelectionPage()),
                    );
                  },
                  child: Text(
                    "Check the ranking",
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB760D5), // Adjust button color (optional)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: Size(125.0, 30.0), // Set desired width and height
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB press action
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
