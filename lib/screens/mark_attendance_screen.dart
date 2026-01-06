import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddNoticeScreen extends StatefulWidget {
  final String userName;
  const AddNoticeScreen({super.key, required this.userName});

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Notice")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: "Notice"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (contentController.text.isEmpty) return;
                bool success = await ApiService.addNotice(
                  widget.userName,
                  contentController.text,
                );
                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to add notice")),
                  );
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
