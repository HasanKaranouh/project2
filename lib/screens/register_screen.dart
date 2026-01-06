import 'package:flutter/material.dart';
import 'package:project2/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _register() async {
    var res = await ApiService.register(
        _nameController.text,
        _emailController.text,
        _passController.text
    );

    if (res['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registered! Please Login.")));
      Navigator.pop(context); // Go back to login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Full Name")),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}