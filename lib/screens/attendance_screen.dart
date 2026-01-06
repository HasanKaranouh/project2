import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'mark_attendance_screen.dart';

class AttendanceScreen extends StatefulWidget {
  final String userName;
  const AttendanceScreen({super.key, required this.userName});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List attendanceRecords = [];

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  void fetchAttendance() async {
    final data = await ApiService.getAttendance();
    setState(() {
      attendanceRecords = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Records")),
      body: ListView.builder(
        itemCount: attendanceRecords.length,
        itemBuilder: (context, index) {
          final record = attendanceRecords[index];
          return ListTile(
            title: Text(record['subject'] ?? ''),
            subtitle: Text("Student: ${record['user_name']}"),
            trailing: Text(record['status'] ?? ''),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  MarkAttendanceScreen(userName: widget.userName),
            ),
          );
          fetchAttendance(); // refresh after marking attendance
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
