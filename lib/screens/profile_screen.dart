import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../models/personal_data.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder<PersonalData>(
        future: dataService.getPersonalData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data!;
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ListTile(title: Text('Full Name'), trailing: Text(data.fullName)),
              ListTile(title: Text('Email'), trailing: Text(data.email)),
              ListTile(title: Text('Date of Birth'), trailing: Text(data.dateOfBirth)),
              ListTile(title: Text('Blood Group'), trailing: Text(data.bloodGroup)),
              ListTile(title: Text('Sex'), trailing: Text(data.sex)),
              ListTile(title: Text('Height'), trailing: Text(data.height.toString())),
              ListTile(title: Text('Ethnicity'), trailing: Text(data.ethnicity)),
              ListTile(title: Text('Eye Color'), trailing: Text(data.eyeColor)),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement profile update logic
                },
                child: Text('Update Profile'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirm Unsubscribe'),
                      content: Text('Are you sure you want to unsubscribe? This action cannot be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Unsubscribe'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await dataService.unsubscribe();
                    Navigator.pushReplacementNamed(context, '/');
                  }
                },
                child: Text('Unsubscribe'),
                // style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ],
          );
        },
      ),
    );
  }
}