import 'package:flutter/material.dart';
import 'package:project2/services/api_service.dart';

class MarkAttendanceScreen extends StatefulWidget {
  final String userName;
  const MarkAttendanceScreen({super.key, required this.userName});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final TextEditingController _subjectController = TextEditingController();
  String _status = "Present"; // Default value

  void _submit() async {
    if (_subjectController.text.isEmpty) return;

    var res = await ApiService.markAttendance(widget.userName, _subjectController.text, _status);

    if (res['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Attendance Marked!")));
      Navigator.pop(context, true); // Return 'true' to trigger a refresh on previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mark Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: "Subject Name"),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(labelText: "Status"),
              items: ["Present", "Absent"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}