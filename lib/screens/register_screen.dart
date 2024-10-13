import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              onSaved: (value) => _user.fullName = value!,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => _user.email = value!,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onSaved: (value) => _user.password = value!,
              validator: (value) => value!.length < 6 ? 'Too short' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Date of Birth'),
              onSaved: (value) => _user.dateOfBirth = value!,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            // Add other registration fields here
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final success = await authService.register(_user);
                  if (success) {
                    Navigator.pushReplacementNamed(context, '/profile');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration failed')),
                    );
                  }
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}