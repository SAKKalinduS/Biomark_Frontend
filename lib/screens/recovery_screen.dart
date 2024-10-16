import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});

  @override
  _RecoveryScreenState createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _dateOfBirth = '';
  String _securityAnswer1 = '';
  String _securityAnswer2 = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Account Recovery')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              onSaved: (value) => _fullName = value!,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Date of Birth'),
              onSaved: (value) => _dateOfBirth = value!,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Mother's Maiden Name"),
              onSaved: (value) => _securityAnswer1 = value!,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Childhood Best Friend's Name"),
              onSaved: (value) => _securityAnswer2 = value!,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final success = await authService.recoverAccount(
                    _fullName,
                    _dateOfBirth,
                    _securityAnswer1,
                    _securityAnswer2,
                  );
                  if (success) {
                    Navigator.pushReplacementNamed(context, '/profile');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account recovery failed')),
                    );
                  }
                }
              },
              child: const Text('Recover Account'),
            ),
          ],
        ),
      ),
    );
  }
}