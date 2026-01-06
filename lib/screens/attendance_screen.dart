import 'package:flutter/material.dart';
import 'mark_attendance_screen.dart';
import '';
import 'attendance_item.dart';

class AttendanceScreen extends StatefulWidget {
  final String userName; // We need to know whose attendance to show
  const AttendanceScreen({super.key, required this.userName});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late Future<List<AttendanceItem>> _attendanceList;

  @override
  void initState() {
    super.initState();
    _refreshAttendance();
  }

  void _refreshAttendance() {
    setState(() {
      _attendanceList = ApiService.getAttendance(widget.userName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.userName}"),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshAttendance
          )
        ],
      ),
      body: FutureBuilder<List<AttendanceItem>>(
        future: _attendanceList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No attendance records found."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: Icon(
                    item.status == "Present" ? Icons.check_circle : Icons.cancel,
                    color: item.status == "Present" ? Colors.green : Colors.red,
                  ),
                  title: Text(item.subject),
                  subtitle: Text(item.date),
                  trailing: Text(item.status, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to Mark Attendance and wait for result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MarkAttendanceScreen(userName: widget.userName)),
          );
          // If we marked successfully, refresh the list
          if (result == true) {
            _refreshAttendance();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}