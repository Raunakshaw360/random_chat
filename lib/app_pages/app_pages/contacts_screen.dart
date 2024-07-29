// lib/contacts_screen.dart
import 'package:flutter/material.dart';

import 'chat_page.dart';

class ContactsScreen extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'John Doe', 'message': 'Hey there!', 'avatar': 'assets/avatar1.png'},
    {'name': 'Jane Smith', 'message': 'Good morning!', 'avatar': 'assets/avatar2.png'},
    {'name': 'Michael Johnson', 'message': 'Let\'s meet up.', 'avatar': 'assets/avatar3.png'},
    {'name': 'John Doe', 'message': 'Hey there!', 'avatar': 'assets/avatar1.png'},
    {'name': 'Jane Smith', 'message': 'Good morning!', 'avatar': 'assets/avatar2.png'},
    {'name': 'Michael Johnson', 'message': 'Let\'s meet up.', 'avatar': 'assets/avatar3.png'},
    {'name': 'John Doe', 'message': 'Hey there!', 'avatar': 'assets/avatar1.png'},
    {'name': 'Jane Smith', 'message': 'Good morning!', 'avatar': 'assets/avatar2.png'},
    {'name': 'Michael Johnson', 'message': 'Let\'s meet up.', 'avatar': 'assets/avatar3.png'},
    {'name': 'John Doe', 'message': 'Hey there!', 'avatar': 'assets/avatar1.png'},
    {'name': 'Jane Smith', 'message': 'Good morning!', 'avatar': 'assets/avatar2.png'},
    {'name': 'Michael Johnson', 'message': 'Let\'s meet up.', 'avatar': 'assets/avatar3.png'},
    {'name': 'John Doe', 'message': 'Hey there!', 'avatar': 'assets/avatar1.png'},
    {'name': 'Jane Smith', 'message': 'Good morning!', 'avatar': 'assets/avatar2.png'},
    {'name': 'Michael Johnson', 'message': 'Let\'s meet up.', 'avatar': 'assets/avatar3.png'},
    {'name': 'John Doe', 'message': 'Hey there!', 'avatar': 'assets/avatar1.png'},
    {'name': 'Jane Smith', 'message': 'Good morning!', 'avatar': 'assets/avatar2.png'},
    {'name': 'Michael Johnson', 'message': 'Let\'s meet up.', 'avatar': 'assets/avatar3.png'},
    // Add more contacts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(contacts[index]['avatar']!),
            ),
            title: Text(contacts[index]['name']!),
            subtitle: Text(contacts[index]['message']!),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },

          );
        },
      ),
    );
  }
}
