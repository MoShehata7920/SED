import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OUR TEAM',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16),
            _buildTeamMember(
              name: 'Mohamed Shehata',
              title: 'Mobile Developer',
              imageUrl: 'http://i.epvpimg.com/tRsTeab.png',
            ),
            SizedBox(height: 16),
            _buildTeamMember(
              name: 'Mahmoud Hafez',
              title: 'Mobile Developer',
              imageUrl: 'http://i.epvpimg.com/y6anfab.png',
            ),
            SizedBox(height: 16),
            _buildTeamMember(
              name: 'Abdullah Ragab',
              title: 'BackEnd Developer',
              imageUrl: 'http://i.epvpimg.com/EKVpeab.png',
            ),
            SizedBox(height: 16),
            _buildTeamMember(
              name: 'Mahmoud Elamrosy',
              title: 'BackEnd Developer',
              imageUrl: 'http://i.epvpimg.com/ioIcfab.png',
            ),
            SizedBox(height: 16),
            _buildTeamMember(
              name: 'Mohamed Adel',
              title: 'FrontEnd Developer',
              imageUrl: 'http://i.epvpimg.com/vTCgeab.png',
            ),
            SizedBox(height: 16),
            _buildTeamMember(
              name: 'Abdelrahman Ezat',
              title: 'FrontEnd Developer',
              imageUrl: 'http://i.epvpimg.com/hB5oeab.png',
            ),
            SizedBox(height: 32),
            Text(
              'Eagles Team',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Project Supervisor: Dr. Mahmoud Elshewimy',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(
      {String name = "", String title = "", String imageUrl = ""}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(imageUrl),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
