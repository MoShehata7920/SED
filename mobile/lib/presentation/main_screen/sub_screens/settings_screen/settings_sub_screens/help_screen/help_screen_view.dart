import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Need help?',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'If you have any questions or issues with our app, please feel free to contact us:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text('Email', style: TextStyle(color: Colors.white)),
              subtitle: Text('support@example.com',
                  style: TextStyle(color: Colors.grey[400])),
              onTap: () {
                // Handle email tap
              },
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text('Phone', style: TextStyle(color: Colors.white)),
              subtitle: Text('+1 (555) 123-4567',
                  style: TextStyle(color: Colors.grey[400])),
              onTap: () {
                // Handle phone tap
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'We appreciate your feedback!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[400],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'By Eagles Team',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
