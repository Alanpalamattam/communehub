import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'eventdetails.dart';

class UserInputPage extends StatefulWidget {
  @override
  _UserInputPageState createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _submitEvent() async {
    try {
      // Create a reference to the Firebase Storage bucket
      var storageRef = FirebaseStorage.instance.ref().child('images');

      // Create a unique filename for the image
      var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      var imageName = 'image_$timestamp.jpg';

      // Upload the image file to Firebase Storage
      var uploadTask = storageRef.child(imageName).putFile(_selectedImage!);

      // Get the download URL of the uploaded image
      var imageUrl = await (await uploadTask).ref.getDownloadURL();

      // Store event details in Firestore including the image URL
      CollectionReference collRef =
          FirebaseFirestore.instance.collection('events');

      // Add the event to Firestore
      await collRef.add({
        'name': nameController.text,
        'date': dateController.text,
        'description': descriptionController.text,
        'image_url': imageUrl,
      });

      // Navigate to EventDetailsPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsPage(),
        ),
      );
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (pickedDate != null) {
                      dateController.text = pickedDate.toString();
                    }
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: dateController,
                      decoration: const InputDecoration(hintText: 'Date'),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                SizedBox(height: 20.0),
                _selectedImage == null
                    ? ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Pick Image'),
                      )
                    : Image.file(_selectedImage!),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitEvent,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
