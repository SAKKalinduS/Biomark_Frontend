import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../models/personal_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<PersonalData>(
        future: dataService.getPersonalData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(title: const Text('Full Name'), trailing: Text(data.fullName)),
              ListTile(title: const Text('Email'), trailing: Text(data.email)),
              ListTile(title: const Text('Date of Birth'), trailing: Text(data.dateOfBirth)),
              ListTile(title: const Text('Blood Group'), trailing: Text(data.bloodGroup)),
              ListTile(title: const Text('Sex'), trailing: Text(data.sex)),
              ListTile(title: const Text('Height'), trailing: Text(data.height.toString())),
              ListTile(title: const Text('Ethnicity'), trailing: Text(data.ethnicity)),
              ListTile(title: const Text('Eye Color'), trailing: Text(data.eyeColor)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement profile update logic
                },
                child: const Text('Update Profile'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Unsubscribe'),
                      content: const Text('Are you sure you want to unsubscribe? This action cannot be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Unsubscribe'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await dataService.unsubscribe();
                    Navigator.pushReplacementNamed(context, '/');
                  }
                },
                child: const Text('Unsubscribe'),
                // style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ],
          );
        },
      ),
    );
  }
}