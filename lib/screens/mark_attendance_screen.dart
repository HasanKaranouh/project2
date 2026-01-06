import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MarkAttendanceScreen extends StatefulWidget {
  final String userName;
  const MarkAttendanceScreen({super.key, required this.userName});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final subjectController = TextEditingController();
  String status = "Present"; // default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mark Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: "Subject Name"),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: status,
              items: const [
                DropdownMenuItem(value: "Present", child: Text("Present")),
                DropdownMenuItem(value: "Absent", child: Text("Absent")),
              ],
              onChanged: (val) {
                if (val != null) setState(() => status = val);
              },
              decoration: const InputDecoration(labelText: "Status"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (subjectController.text.isEmpty) return;

                bool success = await ApiService.markAttendance(
                  widget.userName,
                  subjectController.text,
                  status,
                );

                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to mark attendance")),
                  );
                }
              },
              child: const Text("Submit Attendance"),
            )
          ],
        ),
      ),
    );
  }
}
